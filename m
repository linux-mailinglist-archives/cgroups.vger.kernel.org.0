Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDF41D7A9F
	for <lists+cgroups@lfdr.de>; Mon, 18 May 2020 16:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgEROCi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 18 May 2020 10:02:38 -0400
Received: from sonic305-21.consmr.mail.ne1.yahoo.com ([66.163.185.147]:35389
        "EHLO sonic305-21.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726998AbgEROCh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 18 May 2020 10:02:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1589810557; bh=5gCyJ+OqEpp5mbAlNtNv58P62XCklDNCTlGARRHXZQA=; h=Date:From:Reply-To:Subject:References:From:Subject; b=a45DRfZH73iEQiTzKTybauIUqEc9Kzdtue9bSTXAOvtGNXGDGdltTSDtTRho5yGunlui4XJRkdzuDaxMOjgptqfXGys7Eoc/PpSMzyToVEaj//a2L3mPZNlFFhmV53EnGaRb7hiNybg3Zgt0FEVApZRqD8HgAlVBxzPZbL0KZ8JHxcFbXaL0zestqs5v7fWSjTXCNAKsq70w64DdxbTioLQu9N0RrwD0xfAriwQpb23vYDqGicMnLrnQYKwKmmPv5LjGqIvmuL1oVs1he7QDvLpHJzCJdCCtmSkhgeonYKYVonI+1NdG+6IvVI/yH0PzZVvjWJvAbPhZuXAmuNUmKQ==
X-YMail-OSG: IzOhkGcVM1kr8yiIFCtlvdIclXgPASWerudIs9SQMMOYusYDhhv69lIJNVMWeAy
 EosGwc5mxzvVPfoXvJwGyCrSUcFAHmXI4BQWpJNlwRCfqPUd8pKYWsYmbWDzlzccwrFI8IyiikHW
 1sbYgyiH8qlakeGYL01MHms3vL628bI.m5Y34ihKuUEh5L5wqsWX94H88Z4bAjNBL7Wrtvd9sAxh
 xBTnV3SrgRSEdU5wWhV2UTFA1yC9DF1zgZSwzvFzhnYyRIJpiviI7IXmcJ502PlZyQFahOd_AiRs
 kNxqsZ8C5j1O5lyE8THwwuQ2yH1VTW.Nf7WtTTD7CBvYD_HG1TNXkk5ajeHk8UE5zyTZCMDxBDR.
 niFNGc8WFz7CdyYq9p92i5nrEoTjOIF.HHK7sJ4W3oBKNLKn1p4Ucx6YHfpDVxUgtmnsUbJdOHLR
 F.uhm7d5p.tjd7Colih94niZ1.evaQ7CSju8MXex6WqL7JBGL25Yjnt4Qz6.U2yr4TZ8vi4.q5oO
 YxtlwnFUI_1QDqYam7LjsdGNagi0zX_nOlK4Q9pHg.x7MCj1M9qLL4kvm82pX6vCKdagLO2pARov
 kWu7bD1pOIKGzEP_luqYm2IcmJ4DLGGGfnX2KKmsPcFwITinzg6mh8u3T5bkJSjjuLEXHqe1JlLM
 WyfM8hranPCM281D89UPnNBUFhYBEF_wPPHEZqjQ0CpbTg_UuHK5jNnA62.4SMYeLfDMG_DEY4.h
 lxs9MKSE0PMVFOD7XMiGaQeurxki5FFvcDlXA5CEQacuIDVVvmaz2Zr9aAuU9GXIo7AwbkF7H5oM
 Eq_uHxbJQ499GoVjbvkJJ6njd1F62ZqPw1ZorS7uGQtLv_oUjlbNhdBFokM81Db0w_J6VeFBinAv
 1hDzopzbMeAzcQikLyAaOiO7Bp97Apx8CT7hyGznjiiHVGWzAE1LRn3S22xNH7KleHt78SMS2GgG
 ndLLnhDL.eVgvqU_cfT3W0abSVRk22qLXZGQ.XovyEHpnci0KIM7gnY1DQZA19Z2a2xAZF41aQ1F
 Zlp4VqLsqbUrTM..6RgAjjtsngpvWK4BHIImLXQIKBwAfCtzWcpIgfNn.72VJJhfPSctTQqocmgO
 uM320uFBfdwQ3t3CEWSd9EY9iiEW4IMU2VC7sADfWuwp5s1RxoqLYsSYVCU25AlW0vnLNRp_rhr.
 35uU1y3XT5Lg87QLCmmtR2n1Ed_4BvIIHfi_pbxM76rrMoZ430LuvQvs5Gf_Bsf1PJwDJR.MEYq5
 LksjmxaWj8S3k03KEherfNew8.2DCW56aMsmhnpSSX7_kDU7mWNy_CD.eYHjMAtJF9A--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Mon, 18 May 2020 14:02:37 +0000
Date:   Mon, 18 May 2020 14:02:33 +0000 (UTC)
From:   Rose Gordon <rosegordonor@gmail.com>
Reply-To: rosegordonor@gmail.com
Message-ID: <1126212194.809836.1589810553090@mail.yahoo.com>
Subject: Hi there
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1126212194.809836.1589810553090.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15960 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:72.0) Gecko/20100101 Firefox/72.0
To:     unlisted-recipients:; (no To-header on input)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Best of the day to you I'm Rose by name 32years old single lady, Can we be friends? born and raised in London in United Kingdom Take care Rose.
