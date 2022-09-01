Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E21D5A9312
	for <lists+cgroups@lfdr.de>; Thu,  1 Sep 2022 11:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiIAJ0k (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 1 Sep 2022 05:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233461AbiIAJ0j (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 1 Sep 2022 05:26:39 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8A812CB18
        for <cgroups@vger.kernel.org>; Thu,  1 Sep 2022 02:26:37 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id a18so4249997uak.12
        for <cgroups@vger.kernel.org>; Thu, 01 Sep 2022 02:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date;
        bh=lSK2Psj9elc1lSMOhcFg17TXysE+aTBO+i5mVz4IQ+E=;
        b=TzsiZJ3LwnSYCcgiHeZ6k4XeeMr1+VrkKfvjrbwdDc2sKFte0RmT57/EKrVCWC2xpT
         EkXG3GcFf+zkIAN5FP7wAa26/rjNUzKWay9FTsFrGDJYcUuZNrriK0UTfXiCaLQ/O3gh
         Bt4tz2Qy5M4+UUe7/cM3FXstL8tH6d5I8+KplqCyqMQSEiyIUtE6Mx5rOZJipcYaHNyT
         qQhtjY+2lzbUzwyHCARdNqVBBzcLiPbBISa0A7OHyeIE+93eORXmyMSVVYYpGZK3u8gu
         u3IrPC6VUjjgpj6QUhhJX1c90/LXLVQzj+mISO+sFcaXFAsoteX+/9ITGAFc0YciNIDr
         +t/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=lSK2Psj9elc1lSMOhcFg17TXysE+aTBO+i5mVz4IQ+E=;
        b=24c73CaasSvcui/F0gHs8cxf0eHPD4QMGwU7BG/fYJrtZj6M1IpghgtT0zM65TEL4U
         BwQ0SKkx9a3uOroMZsWhBX1lZPPLCwCk5qBiYW7FJVQd46irtnj60oGlVz9+PQPeVSUb
         1SAEIabvTrhGj7ltvS4ndN+TSu1sLCWIt7Sry5F00zYaGhi1nZoNrLWtd2NlB2bAE1mR
         83Xee1OPKHbyclO6NLPTwZhDH4rzBHVmKNhNNnYwD5reo4JFt/BTDq1O6QEEp6KDQEF1
         JP1NdCNcE6s//lfyfB4J6Z5nywWpFwdUTHdEKfZcp2Ut4eM+KFzQuGGhIhoe2aY+MM6J
         rAHQ==
X-Gm-Message-State: ACgBeo3M1fgfLslc9TY1lSrhOdQnGUqoanP+K4wgIJZFmGyOIy7b5Pps
        FfrgTobdOSVD2IDyWou5sB84j8KRGoSyePeRC8c=
X-Google-Smtp-Source: AA6agR7otF99vvmE5VRftNzFMHTHjSb6z7AJKAmqvGt1dEra5EcDzuWMbrW0bvjPVzaqCkkJvdAW1Sds7NE7R+rjFQk=
X-Received: by 2002:a9f:358c:0:b0:387:9de3:6c8a with SMTP id
 t12-20020a9f358c000000b003879de36c8amr8255716uad.94.1662024396216; Thu, 01
 Sep 2022 02:26:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a59:b8c3:0:b0:2de:d5df:173a with HTTP; Thu, 1 Sep 2022
 02:26:35 -0700 (PDT)
Reply-To: vb6832716@gmail.com
From:   victoria benson <barristeralexandrakojo2987@gmail.com>
Date:   Thu, 1 Sep 2022 09:26:35 +0000
Message-ID: <CAKM58LXkKCC1SpY-ZHPhbg1S_Eoda3FzdW2sKe=qiVmb5sDYTw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:941 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4524]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [barristeralexandrakojo2987[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [barristeralexandrakojo2987[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [vb6832716[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.2 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

i am still waiting for your last message regarding my message to you.
please get back to me and tell me your interest.

Regards

 victoria
