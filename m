Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C63B6C65E0
	for <lists+cgroups@lfdr.de>; Thu, 23 Mar 2023 11:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbjCWK5S (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 23 Mar 2023 06:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbjCWK45 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 23 Mar 2023 06:56:57 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0951EFBA
        for <cgroups@vger.kernel.org>; Thu, 23 Mar 2023 03:56:31 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id z83so24228010ybb.2
        for <cgroups@vger.kernel.org>; Thu, 23 Mar 2023 03:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679568991;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BYcZPqH3I6SUi+3HZiGlz7bBbKQQVG9vXsJL8zyyX8g=;
        b=hGKGhrwUhF6Zr58bWw28qEqhFbGEsuGX03A+ZEtGRkcE9kRcpOye6f49Xmu5s3bHyw
         mgDnCLlVPL5elRFxau0g/qpfHnf2fqWdkw1Ne4JJxaPFw3On3RWpPoBbD0v4JprzDFR4
         Kz06I4B7l+6BMxKQeptg53xHWGLSGYxQ6/cM4RJ9D6D8TEyy3VIkvTECJuDf4p0+e171
         I00dCQH3+tZDrOTrYus9JqbFpwj8QwgxZegkxlw66n5/ho5bRRBlI2fyfb0qHVnY+0S4
         +DSPaR6S/oPz/31pb+rk6rBJjEbYiB/eMCLmPaRI60zfeqDe9v9/4GnttnifD4NIuwCC
         zcXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679568991;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BYcZPqH3I6SUi+3HZiGlz7bBbKQQVG9vXsJL8zyyX8g=;
        b=lfcR+m6h0gtmr1R1ExklUfrv6NaqTeVjtvMJsv0yGHIXY82jLXHJLndyFHWNwFJ4lg
         NbSeUD6OleatpI3PnmxbDgBiCj3VpZfuk0DysFbEzK+w6G0XXpxRh67UFHUUljUZ7Dis
         uh1lwlffZmXSR9T4fUzWLtwiHNSKb/QuM3kb5rmYW4MnQX7yFgIBp0ORiARDwAHrujR5
         RlE2QHnmYtEdjVgoqbOAcpERXcsWJT85aLrUZNXsPEtInEwL2p+8IjQxDVDcCVets+RO
         B1jY5hLlGg+kNVqeloUM62UjXuj4PcUAXtOiuQnV7dK+xVptnG82VguQpBCdzF2B5WVb
         91oQ==
X-Gm-Message-State: AAQBX9dT2PTSXkHDhjrw4H4dnlMXUkAw6JpayNwfU+r1Ss9Ps4MGCLZf
        v44Jfg3Kenm1ztbAoIbaP0H6PGDo87hWHeoGAH4=
X-Google-Smtp-Source: AKy350aalZ/8IQu2SPaqfPLEjMhYKpbdFcYf/RJwBvX/Mp7DE7PbQ7BjumNzD6O6kDRpLJsvIT6sJucdTRX4lFDUww8=
X-Received: by 2002:a05:6902:1105:b0:b2f:bdc9:2cdc with SMTP id
 o5-20020a056902110500b00b2fbdc92cdcmr1922153ybu.7.1679568990662; Thu, 23 Mar
 2023 03:56:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7000:c421:b0:47c:b23e:c6d4 with HTTP; Thu, 23 Mar 2023
 03:56:30 -0700 (PDT)
Reply-To: annamalgorzata587@gmail.com
From:   "Leszczynska Anna Malgorzata." <revfatherwilliamdick@gmail.com>
Date:   Thu, 23 Mar 2023 03:56:30 -0700
Message-ID: <CAMKwiRXAt2ALo4Tfh5JEh33NZn58r8+49QqesFPhP2P5c=mtyw@mail.gmail.com>
Subject: Mrs. Leszczynska Anna Malgorzata.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.8 required=5.0 tests=ADVANCE_FEE_5_NEW,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM,UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b42 listed in]
        [list.dnswl.org]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [revfatherwilliamdick[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [annamalgorzata587[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  0.8 ADVANCE_FEE_5_NEW Appears to be advance fee fraud (Nigerian
        *      419)
        *  2.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

-- 
I am Mrs. Leszczynska Anna Malgorzatafrom Germany . Presently admitted
 in one of the hospitals here in Ivory Coast.

I and my late husband do not have any child that is why I am donating
this money to you having known my condition that I will join my late
husband soonest.

I wish to donate towards education and the less privileged I ask for
your assistance. I am suffering from colon cancer I have some few
weeks to live according to my doctor.

The money should be used for this purpose.
Motherless babies
Children orphaned by aids.
Destitute children
Widows and Widowers.
Children who cannot afford education.

My husband stressed the importance of education and the less
privileged I feel that this is what he would have wanted me to do with
the money that he left for charity.

These services bring so much joy to the kids. Together we are
transforming lives and building brighter futures - but without you, it
just would not be possible.
I am using translation to communicate with you in case there is any
mistake in my writing please correct me.
Sincerely,

Mrs. Leszczynska Anna Malgorzata.
