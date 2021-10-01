Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC1041F7E2
	for <lists+cgroups@lfdr.de>; Sat,  2 Oct 2021 00:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbhJAW6U (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 1 Oct 2021 18:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356170AbhJAW53 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 1 Oct 2021 18:57:29 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA82BC061775
        for <cgroups@vger.kernel.org>; Fri,  1 Oct 2021 15:55:44 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id oa12-20020a17090b1bcc00b0019f715462a8so2837404pjb.3
        for <cgroups@vger.kernel.org>; Fri, 01 Oct 2021 15:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=bcOf58M2CkuKQ+z7AQKAMx1/0RxBEvOdzkCCDatP0w4=;
        b=Gi1wVXsxoNsdtZV60pYfOP0zevU95rxjJrAenqV4gwVk2j6FPqucDXmyJOULncPURf
         jpA6i4Qe2kicvO8ak8FCWdd7kG2gEOcD1deR5vQtE6D7yz/8J1uBEGYsKLZJajbbbRc4
         kRMpaWw+++DpbU35ARuQBQcmoGI6eHSAaZ0V45ngiYSi08Mbd5BVC7drNaVVuZiuQI24
         Cnv8xTRUafruylZQe7PYjW1iXR2hGn8FCYJ3ExG79o8OvmSpzz90mh1SmATmG4pzaP3k
         K4yvCWyWdGAZzRqhPVPT8jVBwnJGrW6j5qkfJkgefqaUrx2i5e9TTSHuZh7p5J6IXQZd
         YO5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=bcOf58M2CkuKQ+z7AQKAMx1/0RxBEvOdzkCCDatP0w4=;
        b=sA+owg122zq6Z++CmC1CBr0X18NzRV6DCwCeSQdtFupnGZV/OBgiRGj9NQ5OnEjNol
         ENQZHR6IYuyZazVCqvVp8KXBv9pxP/NfubTDG6oAfCN3ZvjEgl4zVJsq/HWoynwOKbNJ
         5IUOCutzB5b76EFDhoGzxl1NgjjeHtFTE+mPJxp5VUQeM3Cpjp5HD+w192a04tV8J/Oq
         +5V3twoORlgKJRQyiLFlPtnvDJKbhea3ghDV+phEg5Pr1yVFMhxmAJYmZFCDNHHbwgux
         zPxFq7GBhP5rV/CMExhKIBxQo0ItsZP8vIxJIgcfjVtEx3mixUShbtkarTEKaOfY4+OD
         TsuA==
X-Gm-Message-State: AOAM532aqWf+FXiPzYwg720iUVJBxx4W8eXtvsYMDFl5mKBAwy/N4enS
        Gm0iR27nUWdzf8b69gbKM8Yn7ZNtWoYThzSInvY=
X-Google-Smtp-Source: ABdhPJw9dL/4AH8LhsPAoRjpPt6vFvE2L2qs/M7cO/wKgRne7rXqKHLuy1858/g58LG1k6cvVhMsmx7j95rEQ6szwZc=
X-Received: by 2002:a17:902:6bc1:b0:13e:8f27:c6e6 with SMTP id
 m1-20020a1709026bc100b0013e8f27c6e6mr3133229plt.62.1633128944379; Fri, 01 Oct
 2021 15:55:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a10:e98f:0:0:0:0 with HTTP; Fri, 1 Oct 2021 15:55:43
 -0700 (PDT)
Reply-To: bill.melindagates560@gmail.com
From:   "Bill & Melinda Gates" <nkekerakan@gmail.com>
Date:   Fri, 1 Oct 2021 15:55:43 -0700
Message-ID: <CAH8LAEct7GnBk_B05R=ZAaDijW84hv8j+h=Qtx1+k85dz537tg@mail.gmail.com>
Subject: Spende
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

-- 
Hallo beste gewaardeerde gelukkige winnaar,

We hebben een suggestie voor u met betrekking tot de Bill & Melinda
Gate-donatie die u samen met de gelukkige winnaars van $ 3.500.000,00
(drie miljoen, vijfhonderdduizend dollar) hebt vermeld. U kunt contact
met ons opnemen via e-mail (bill.melindagates560@gmail.com) voor meer
informatie, ik hoop van u te horen.

Groeten
GEFELICITEERD!!

Groetjes en God zegene je

Wettelijke vertegenwoordiger Bill & Melinda Gates
Missie Stichting Humanitaire Zaken.
