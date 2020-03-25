Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41D9F1921CD
	for <lists+cgroups@lfdr.de>; Wed, 25 Mar 2020 08:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbgCYHiT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 25 Mar 2020 03:38:19 -0400
Received: from sonic309-15.consmr.mail.bf2.yahoo.com ([74.6.129.125]:41601
        "EHLO sonic309-15.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725907AbgCYHiT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 25 Mar 2020 03:38:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1585121897; bh=YdDyVS9QBRPCiN2YYZ/cryZSa6YEXSJJY6ujWZ06LZ8=; h=Date:From:Reply-To:Subject:References:From:Subject; b=dsneZpzzwrH06ECcu4nAV5X4jM1zdLsX9J1wUWYy61P49nlPgp9I5GEzZU9amw3tR1x/ImYWQFyjr9qdNT8fwsoI/cNo2hWHr7msEht1WphRCMwutW1fJXK6BgF5xj9oZiP3nshLr2GkhtpmqOg3CCWLd5sVB83JLdfqqiocZ9v6oieZXC4UKSad8B8dwjnzMAOrJg/JAeQcolvSPboXCJPp4N5tP/sTIf6HOCp6osjAGinF5kBZ2Pw6c8cGk9CrVgA7jmSzW1VH51hZSCgjQUwD/IyXAtO8fR/88IFd4AzxyMcAaN/oHPYele20HWy3OiLH9aOjt+XNr8sYvkzq4Q==
X-YMail-OSG: uWSBrNMVM1mXV_Lg8Cus8eKSgmWKIgnJ0z7C2xK2IbzO41zWkKbPcgT7gO7RNbd
 UBiYRWdYTqGcMfEuhpJLj5X1yNXYGGpskN6raLp9u4XCgGvunUiknMCQBLqho5nnXSliqgmPXVon
 PKAhzrZ_4tdbrTjHB5RHJmeSKiLRzUkAyMbJuaIdZOWnoGcsFf89vD2RNHYyjnG3yVg_PPFCkIuN
 20ODt.kJuscihQJZprmzPo_B9Dkf_XUYFfkixaAxwBlB41KoquVMMujNJaH_8yWlOh9fq7jE6sGm
 X2eEPw9a5nnJh2C1xGsZBuVnVJxjSeua8gCbiCckqKJPHEWeHWyprGsfnhhQg5dsmYcfESllYj4H
 x_QZoFW3KSee3NDG42zQeh4ddNCWAMkQ2agw8zlus3V5eWw8qbfiyidBre8I.k4cwqgECYhz6UIL
 .7Utmy7jTdxlAJjidZpEOl4vTNhwSfLxgNsOBePyDNq57auzXOWGKid52NpsaR2dpan8pGgUJD_w
 zDTNsW7hbf51NtOA53aom_IfCIBWJClzMlpdy93qqao3ucHDfe2qtUllB9wTAxkZJI.OGWxZbHZn
 j5Cli._sRgXxuaE8rlaK3rcg1WDqUtqkzBRcD60LIVD9SMff717zr62V_GWx6FWyRF1P3iTnjIX8
 35WxcGVr75p0K8lTe9rDLPxZS1gpKObp0WnY8RzHKYQMEoZjmXRf99PYwl4kvc22jWPjeIlqRp5h
 ViWaAj88Mlzg1YUI52XL5EsYfixTLJcv9KSTqtnuKLEqows_rxaKTmzHQlZqBRGMiE3Uw69.Bay_
 Buc5L1Ek3N6X2lvfkw6GGdn8KwD03xThi8oncP5BxrcXxiCSp59OnT7m2AIFZ14Bo9z4iVcqdjSk
 njmPwBCvcIAFEGJvoJPzlYu0Ty6b.HAwjtx_KIdJ69TeD3G_cjVw47XN0EJgSwk2V3K6A_ruzJAb
 Na7evbg9nuqOFft4Wd.pZFoM1Y2uhWY56gsgTL4dpCgp1q9WcvATW.q3pT56tNI_C6C03aUc2.hO
 vkX1FR14XMd.WqWmWN.uu2Br01VVZR7BfdyDB_IBA2z4U_FatehNP7H8GOj.CHixU_90H8h222gU
 6fq3CjEC9U_03XYaaP6J5xQ7Xt_6AQy5zOk6UfWRCx.4eVQXezMFmVxELHWlqbSaUw6iodmGI9_B
 klAIk0YCmUbsbtIERWyZG9qR3d1_GHk88rixOtRAY_VJBN7yFq6fshr3en3DS4oBQWVKbN.dHPKv
 MrdCSrXBy5YdF69X9gkJvS25DNdMSK7sG6xwSi56KS3RHrcI7uXEUHIaAd5V8kaXtUWP0HBUx2nV
 thr2VOw4C8wNsL8x4joIb8Nhh
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.bf2.yahoo.com with HTTP; Wed, 25 Mar 2020 07:38:17 +0000
Date:   Wed, 25 Mar 2020 07:38:14 +0000 (UTC)
From:   Mr Moussa Dauda <officefilelee@gmail.com>
Reply-To: mrmoussadaudaa@gmail.com
Message-ID: <822316687.1110237.1585121894168@mail.yahoo.com>
Subject: I await your urgent response immediately.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <822316687.1110237.1585121894168.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15518 YMailNodin Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:74.0) Gecko/20100101 Firefox/74.0
To:     unlisted-recipients:; (no To-header on input)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



Dear Good Friend,

Good Day,

I am Mr. Moussa Dauda, Director In charge of Auditing and accounting department of Bank Of Africa, BOA, I hope that you will not betray or expose this trust and confident that i am about to repose on you for the mutual benefit of our both families.

I need your urgent assistance in transferring the sum of TEN MILLION FIVE HUNDRED THOUSAND UNITED STATES DOLLARS, U$10,500.000.00, immediately to your account anywhere you chose.

This is a very highly secret, i will like you to please keep this proposal as a top secret or delete it if you are not interested, upon receipt of your reply, i will send to you more details about this business deal.

I will also direct you on how this deal will be done without any problem; you must understand that this is 100% free from risk.

Therefore my questions are:

1. Can you handle this project?
2. Can I give you this trust?
If yes, get back to me immediately.

Try and get back to me with this my private email address ( mrmoussadaudaa@gmail.com )

I will be waiting to hear from you immediately.

Regards
Mr. Moussa Dauda.
