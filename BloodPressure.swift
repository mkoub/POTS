//
//  BloodPressure.swift
//  OCKSample
//
//  Created by Masha Koubenski on 8/17/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import ResearchKit
import CareKit

/**
 Struct that conforms to the `Assessment` protocol to define a blood glucose
 assessment.
 */
struct BloodPressure: Assessment {
    // MARK: Activity
    
    let activityType: ActivityType = .bloodPressure
    
    func carePlanActivity() -> OCKCarePlanActivity {
        // Create a weekly schedule.
        let startDate = DateComponents(year: 2016, month: 01, day: 01)
        let schedule = OCKCareSchedule.weeklySchedule(withStartDate: startDate as DateComponents, occurrencesOnEachDay: [1, 1, 1, 1, 1, 1, 1])
        let thresholds = [OCKCarePlanThreshold.numericThreshold(withValue: NSNumber.init(value: 60), type: .numericRangeInclusive, upperValue: NSNumber.init(value: 100), title: "Healthy heart rate."), OCKCarePlanThreshold.numericThreshold(withValue: NSNumber.init(value: 101), type: .numericGreaterThanOrEqual, upperValue: nil, title: "High heart rate.")] as Array<OCKCarePlanThreshold>;
        
        // Get the localized strings to use for the assessment.
        let title = NSLocalizedString("Blood Pressure", comment: "")
        let summary = NSLocalizedString("After dinner", comment: "")
        
        let activity = OCKCarePlanActivity.assessment(
            withIdentifier: activityType.rawValue,
            groupIdentifier: "Assessment",
            title: title,
            text: summary,
            tintColor: Colors.purple.color,
            resultResettable: false,
            schedule: schedule,
            userInfo: nil,
            thresholds: [thresholds],
            optional: false
        )
        
        return activity
    }


//BLOOD PRESSURE
 func task() -> ORKTask {
    let quantityType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bloodPressureSystolic)!
    let unit = HKUnit(from: "mmHg")
    let answerFormat = ORKHealthKitQuantityTypeAnswerFormat(quantityType: quantityType, unit: unit, style: .decimal)
    
    
    let systolic = ORKFormItem(identifier: "systolic", text: "Systolic", answerFormat: answerFormat)
    let diastolic = ORKFormItem(identifier: "diastolic", text: "Diastolic", answerFormat: answerFormat)
    
    var bloodPressureItems = [ORKFormItem]()
    bloodPressureItems += [systolic, diastolic]
    
    let bloodPressureFormStep = ORKFormStep(identifier: "blood pressure", title: "bp", text: "bp")
    bloodPressureFormStep.formItems = bloodPressureItems
    
    let task = ORKOrderedTask(identifier: "BloodPressureTask", steps: [bloodPressureFormStep])
    
    return task
    }
}
