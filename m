Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C20C962116E
	for <lists+cgroups@lfdr.de>; Tue,  8 Nov 2022 13:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234015AbiKHMvh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 8 Nov 2022 07:51:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233764AbiKHMvg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 8 Nov 2022 07:51:36 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4713BEE
        for <cgroups@vger.kernel.org>; Tue,  8 Nov 2022 04:51:35 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id v124-20020a1cac82000000b003cf7a4ea2caso11619816wme.5
        for <cgroups@vger.kernel.org>; Tue, 08 Nov 2022 04:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SzBlYeGeT15Xra75w9IZDBjQ7Da3XKSmRdlnDJDYrko=;
        b=Am15aRt3/FFU3AABqlZJ1Qu6rTELZlCMJGJyoga0tfV+PoNrNqItL7v9h3LdP7EQG/
         ARNG5+3UyvynUgChwsGJk+z/DHB7BuqXqE63maSEKxF6sCf0qTco2iHHewCZQLWy2Sb5
         buWinopCQyYL/GS/AzilwBJiG3RTqCHYtlV6w563BvF1P91khtFhVzfJCz+B6GYjZ7rI
         oqbHKRFrrn/PYA7/JDa9rcnlTngus7JjjdGhbMpiixGILid2GHd8TUti5bXBgOwku8pv
         IglGYCbAXKkdR/54UxO1I13OYHilLWu/M8jCoojeOjCjRa0L9rtqS111y+NYjGCeK1sX
         /3rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SzBlYeGeT15Xra75w9IZDBjQ7Da3XKSmRdlnDJDYrko=;
        b=uo+SDlzxkWECRCQMsWR/BTTjAQrVWyHn2IEQsvKydY1bBUjmCX4fulO5bOokH+o4KF
         0kAY9t34k4uL0pC+cbR5Go0+J2lNue0tGuP/MP/4B1HAXsMUAvTWlGMCK4CIO7vy1rI5
         6CtxeyBcWgifmW+FyXJEuZRKuDiyy6YmOEfzKeCuDFWcGqEuniLlbWZSeAGEyyXeb3h8
         dQK+iQN2+b2kPjZu2+9C42Mz19jHwjcV/eSnlct3VCM2hhbFCmpBiGXqkBTY3Esln3Z8
         /0EjwIJNxuW+SUZPSR5+p11DipAUs1JBXetit+kOB1ksDHvt0UPE4jHwzaVYAXXgxmlS
         JAlw==
X-Gm-Message-State: ACrzQf3d6q/1myPb7DtOPhPhUbbcLVMncGqCJB8yX+Fg2Z/uycSNiU6u
        6+julpjv2OEN93b3s4AA6ulXbpg5AWvM+qWDeng=
X-Google-Smtp-Source: AMsMyM5FovRJgRLLDXtWZXonAnwXdL8xgWxfq76DlZDmoYz7jZFpsz/Qj75meDiN8TGJxiqTkitKPbdlVpsQmIe5WgE=
X-Received: by 2002:a05:600c:6023:b0:3cf:7dc1:e08e with SMTP id
 az35-20020a05600c602300b003cf7dc1e08emr27375148wmb.154.1667911893959; Tue, 08
 Nov 2022 04:51:33 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6021:f08:b0:22b:1bef:1706 with HTTP; Tue, 8 Nov 2022
 04:51:33 -0800 (PST)
Reply-To: mr.abraham022@gmail.com
From:   "Mr.Abraham" <fofoneabraham@gmail.com>
Date:   Tue, 8 Nov 2022 12:51:33 +0000
Message-ID: <CACQYsd_86EskwgmAn-0JzC49VxbKQEPUKAZn2JUhgtSEfin-qQ@mail.gmail.com>
Subject: Greeting
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

My Greeting, Did you receive the letter i sent to you. Please answer me.
Regard, Mr.Abraham
