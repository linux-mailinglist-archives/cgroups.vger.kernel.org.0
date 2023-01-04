Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B22765CE03
	for <lists+cgroups@lfdr.de>; Wed,  4 Jan 2023 09:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233767AbjADIGG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Jan 2023 03:06:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbjADIGG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Jan 2023 03:06:06 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB93B7CD
        for <cgroups@vger.kernel.org>; Wed,  4 Jan 2023 00:06:05 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id c34so40924566edf.0
        for <cgroups@vger.kernel.org>; Wed, 04 Jan 2023 00:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AgsU3TKYj1ea+xyRd1YeQ6QbaDveXYDp3sPPYkvfdzA=;
        b=PGGZz/errlCrdY54pcd746i5wphxwqlHHQZTpmvHbkziVFDwBH3p1fjq1HPo7m6oGa
         Ip77e2Xqiv0Ce3/H6xiz1BRH15s82Ta6jriYBpIePjN+ACyPoIBeOI5bBI+LWCw7zS6L
         UvzPzZiR1hx0g09BqfZloDE657RqDb7VduajESitX5XabBC+DMc7NlSXKF5OLz7CvvIU
         HG+L3FK/vmxxqVqXry9oWiivZtvtvE5Dy8nbJtpCVMrCE4Gwbj82M67ueOIa29fnqn+9
         cbZhj8AaPfgB9GMg8it6S2l+OJqDdtPATjmWe9ZNdx9hw7lpVziuzEcorJiSIrfskwsL
         7omQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AgsU3TKYj1ea+xyRd1YeQ6QbaDveXYDp3sPPYkvfdzA=;
        b=mSDxcJJh72PlU459niNtvAe2bwqE/hInjGnnTeSom9fbxoBovG1Tyo/9Ya7taLoE7l
         iA4evjPMF/o5dHmlADdfrykaYrz+OWP6dWwcl4ss6RV3B5Jv5Jxj4w4L0BDYup20d8lz
         5XklIRGbSIZ+Vf8Jehgs8Uc0j+5kdHmfIOGkO0S2J2tqMaarSyM/UqeGlkDxqkHhk0+H
         QjIqIGGasWcLQagSnJtYmm7QlNB0M+GNKvOkZSwTC5P10uzsNOSQu0X7Fgjh4RWANPOT
         /X3nCeFPPulUhCU7sZrVqRilgJkjBX7L7QxlydMXP2uhD3dehW0Yn5RaXZ+gUC1a/eeX
         KiAg==
X-Gm-Message-State: AFqh2kpOmWpjU6OF7cIhCLdqnemXlxRaaNugt/VqZK8QwOCzbVQeAMvL
        SZPnhAANVJg9q35KXwClfp0lpvjlhbR2+sa4uw==
X-Google-Smtp-Source: AMrXdXtr5L5Dcm7ltz+fyueRNf/R3RAJ6jzLPh33R/YUjK8u9bl6NwAMAhyD4rdn+79XOoBfOV94dutFme8n3Zc0o2g=
X-Received: by 2002:a05:6402:1394:b0:48a:eac7:2b9f with SMTP id
 b20-20020a056402139400b0048aeac72b9fmr1553016edv.91.1672819563408; Wed, 04
 Jan 2023 00:06:03 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7208:8297:b0:5e:de3b:d9a6 with HTTP; Wed, 4 Jan 2023
 00:06:02 -0800 (PST)
Reply-To: Gregdenzell9@gmail.com
From:   Greg Denzell <denzellgreg392@gmail.com>
Date:   Wed, 4 Jan 2023 08:06:02 +0000
Message-ID: <CALb=U3mbQW1W02JBjSMyzhOGtQ6dzWrdSpLaxzrDem0=9b3KNg@mail.gmail.com>
Subject: Happy new year,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Happy new year,


This will remind you again that I have not yet received your reply to
my last message to you.
