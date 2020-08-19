Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F37B0249B17
	for <lists+cgroups@lfdr.de>; Wed, 19 Aug 2020 12:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgHSKuf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 19 Aug 2020 06:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728211AbgHSKuY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 19 Aug 2020 06:50:24 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B9EC061757
        for <cgroups@vger.kernel.org>; Wed, 19 Aug 2020 03:50:24 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id n25so11692290vsq.6
        for <cgroups@vger.kernel.org>; Wed, 19 Aug 2020 03:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=7JqLKSUFdGdLy72GqIL1pnksOMo8WeFdq7kCu4Cdvdc=;
        b=R1yt/KtnUZxDh7puLqxjlE1kR3/nMFP6JC3fBdGSl5URQDjv0HhyMfHpXtC25zd8tO
         ngvGuKDnufw97OLTaHeYwhu/miJwBHOSYHCMovRVdSc7jMoWuLPUAndl21QnGR564PLT
         IlKXPVuKCLVwrNyndm7qFN5gQEY9ezi03Q87IBHa0I8BnFnIVN1WW/PQwu4mJsTgE7CX
         0c5bIDa2hqM9eM25ATW2VlJ0BEdMDdY5BzmTZ0BEyDnpwXgV7YBcZYgmLut2Q4pWA866
         3VCSIVta13bBniltOZBOIpu6h7kAfiPzVFjNsz7vB7H65E2BNPBOh/47sSPsI1HFykGd
         Cibg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=7JqLKSUFdGdLy72GqIL1pnksOMo8WeFdq7kCu4Cdvdc=;
        b=rzGENvgEcalZoX4sWGWSOPxAxycbUBR3rzdzk5SWZUmzUyBGMBMmMYvTsJimali/h5
         1kbGpzl0v9wp1BErShLJmuSlHTZNo3WtHomVlg7KKa4iCe6rhrN9FGak9Jh5v2P6Sv+e
         4fccpBSrkNzoKAyXnR1HmTx0YBbFK9a1rFdMMIN+un7Xirs/MfvYwnT1LU1B/gjC8e/s
         59X00rU1MdVHYGxyJYTIJuhChQRfpLgJ9W4GXXUYOci435UngIxh1h576LHi5GampUwq
         n0bwzkXEG8fqUfm3TXbUzFxszzABHSONHEtYL8XUStqHoq++4u08CcBV6TrS398cD25C
         jXPA==
X-Gm-Message-State: AOAM532vp505btzgSeKbAxcDRJe9Mi3EpiLIx8CRRub2HxejDE390V8s
        RkzMyJbn2GSpiwHQObld2lQlVtZy8sQlnFbD46g=
X-Google-Smtp-Source: ABdhPJyZ2orM3uIY6d5e8QfvB7VoYEeV2JdIqsS+C3cn8y9jx1zEH679fDJz2AkXQI3PV58SVcbDXOevn8akzZv2gHY=
X-Received: by 2002:a67:683:: with SMTP id 125mr13264088vsg.168.1597834223154;
 Wed, 19 Aug 2020 03:50:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6102:205b:0:0:0:0 with HTTP; Wed, 19 Aug 2020 03:50:22
 -0700 (PDT)
From:   robert anderson <robertandersonhappy2@gmail.com>
Date:   Wed, 19 Aug 2020 03:50:22 -0700
Message-ID: <CABzJeR-MBhdWbXd5LavHJBT=n379ACzHF9FpSM6gRvBeUkhMFQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

KiDQktC90LjQvNCw0L3QuNC1OiDQsdC10L3QtdGE0LjRhtC40LDRgCAqDQoNCiog0KHQvtC+0LHR
idC40YLQtSwg0YfRgtC+INC80Ysg0L/QvtC70YPRh9C40LvQuCDRg9GC0LLQtdGA0LbQtNC10L3Q
vdGL0Lkg0YTQsNC50Lsg0L7Qv9C70LDRgtGLINC+0YIgRkVERVJBTA0K0JzQmNCd0JjQodCi0JXQ
oNCh0KLQktCeINCk0JjQndCQ0J3QodCe0JIg0YHQvtCy0LzQtdGB0YLQvdC+INGBINCc0LXQttC0
0YPQvdCw0YDQvtC00L3Ri9C8INCy0LDQu9GO0YLQvdGL0Lwg0YTQvtC90LTQvtC8ICjQnNCS0KQp
DQrQutC+0LzQv9C10L3RgdCw0YbQuNGPINC20LXRgNGC0LLQsNC8INC80L7RiNC10L3QvdC40YfQ
tdGB0YLQstCwINC4INCy0LDRiCDQsNC00YDQtdGBINGN0LvQtdC60YLRgNC+0L3QvdC+0Lkg0L/Q
vtGH0YLRiyDQstGF0L7QtNC40YIg0LIg0YHQv9C40YHQvtC6DQrQttC10YDRgtCy0YsuICoNCg0K
KiDQryDQv9C40YjRgywg0YfRgtC+0LHRiyDRgdC+0L7QsdGJ0LjRgtGMINCy0LDQvCwg0YfRgtC+
INC80Ysg0LHRg9C00LXQvCDQvtGC0L/RgNCw0LLQu9GP0YLRjCDQstCw0LwgJCA1MDAwLjAwVVNE
DQrQtdC20LXQtNC90LXQstC90L4g0YENCtC90LDRiCDQvtGE0LjRgSDQt9C00LXRgdGMLCDRgtCw
0Log0LrQsNC6INC80Ysg0L/QvtC70YPRh9C40LvQuCDQvNCw0L3QtNCw0YIg0L3QsCDQv9C10YDQ
tdC00LDRh9GDINCy0LDRiNC10LPQviDQv9C+0LvQvdC+0LPQvg0K0LrQvtC80L/QtdC90YHQsNGG
0LjQvtC90L3Ri9C5INC/0LvQsNGC0LXQtiDQsiDRgNCw0LfQvNC10YDQtSA4MDAgMDAwINC00L7Q
u9C70LDRgNC+0LIg0KHQqNCQINCc0LXQttC00YPQvdCw0YDQvtC00L3Ri9C8DQrQstCw0LvRjtGC
0L3Ri9C8INGE0L7QvdC00L7QvA0KKNCc0JLQpCkg0Lgg0KTQtdC00LXRgNCw0LvRjNC90L7QtSDQ
vNC40L3QuNGB0YLQtdGA0YHRgtCy0L4g0YTQuNC90LDQvdGB0L7Qsi4g0JLQsNGIINC70LjRh9C9
0YvQuSDQuNC00LXQvdGC0LjRhNC40LrQsNGG0LjQvtC90L3Ri9C5INC90L7QvNC10YANCtC/0YDQ
tdC00L7RgdGC0LDQstC70LXQvdC+INC60L7QvNCw0L3QtNC+0LkgSS5NLkYgQ1BQMDkyMFRHLiAq
DQoNCiog0JLQvtGCINC40L3RhNC+0YDQvNCw0YbQuNGPINC+0LEg0L7Qv9C70LDRgtC1LCDQutC+
0YLQvtGA0YPRjiDQvNGLINCx0YPQtNC10Lwg0LjRgdC/0L7Qu9GM0LfQvtCy0LDRgtGMINC00LvR
jyDQv9C10YDQtdGB0YvQu9C60Lgg0LLQsNGI0LXQs9C+DQrQtdC20LXQtNC90LXQstC90YvQuSDQ
v9C10YDQtdCy0L7QtC4gKg0KDQoqINCY0LzRjyDQvtGC0L/RgNCw0LLQuNGC0LXQu9GPOiDQodC4
0L3RgtC40Y8g0JjQtNC10L0gKg0KKiDQktC+0L/RgNC+0YE6INCe0L/Qu9Cw0YLQsCAqDQoqINCe
0YLQstC10YI6INCU0LAgKg0KKiDQodGD0LzQvNCwOiA1IDAwMCwwMCDQtNC+0LvQu9Cw0YDQvtCy
INCh0KjQkCAqDQoqINCT0L7RgNC+0LQ6INCb0L7QvNC1ICoNCiog0KHRgtGA0LDQvdCwOiDQotC+
0LPQviAqDQoNCiog0J/QoNCY0JzQldCn0JDQndCY0JU6IE1UQ04g0LHRg9C00LXRgiDQvtGC0L/R
gNCw0LLQu9C10L0g0LLQsNC8INC/0L7RgdC70LUg0LLQsNGI0LXQs9C+INC+0YLQstC10YLQsCDQ
uCDQv9C+0LTRgtCy0LXRgNC20LTQtdC90LjRjw0K0JjQvdGE0L7RgNC80LDRhtC40Y8g0L4g0LLQ
sNGI0LXQvCDQv9C+0LvRg9GH0LDRgtC10LvQtSwg0YfRgtC+0LHRiyDQuNC30LHQtdC20LDRgtGM
INC90LXQv9GA0LDQstC40LvRjNC90L7QuSDQv9C10YDQtdC00LDRh9C4LiAqDQoNCiog0JzRiyDQ
ttC00LXQvCDQstCw0YjQtdCz0L4g0YHRgNC+0YfQvdC+0LPQviDQvtGC0LLQtdGC0LAg0L/QviDR
jdGC0L7QvNGDINCw0LTRgNC10YHRgw0KKG1pc3NjeW50aGlhZWRlbjU2QGdtYWlsLmNvbSA8bWlz
c2N5bnRoaWFlZGVuNTZAZ21haWwuY29tPiksINGH0YLQvtCx0Ysg0L/QvtC30LLQvtC70LjRgtGM
INC90LDQvA0K0L/RgNC+0LTQvtC70LbQuNGC0Ywg0L7Qv9C70LDRgtGDLiAqDQoNCirQmNGB0LrR
gNC10L3QvdC1INCy0LDRiCwqDQoNCirQoNGD0LrQvtCy0L7QtNC40YLQtdC70Ywg0YTQuNC70LjQ
sNC70LA6Kg0KKiDQnNC40YHRgSDQodC40L3RgtC40Y8g0JjQtNC10L0gKg0K
