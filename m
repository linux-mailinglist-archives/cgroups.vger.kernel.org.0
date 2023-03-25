Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2216C8E8D
	for <lists+cgroups@lfdr.de>; Sat, 25 Mar 2023 14:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjCYNeU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 25 Mar 2023 09:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjCYNeT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 25 Mar 2023 09:34:19 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B3B1164E
        for <cgroups@vger.kernel.org>; Sat, 25 Mar 2023 06:34:18 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id o26-20020a4ad49a000000b0053964a84b0fso690449oos.7
        for <cgroups@vger.kernel.org>; Sat, 25 Mar 2023 06:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679751258;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eh5aYFqZy2Za1WtYyCdyh5/bECI/l/Vq/asdBbu3I+I=;
        b=cpjeoOMGPyXgMBozkpT8+2Eqxt2UHAQQi2c8sIU765f8DiPuwZ0whwdlVw6PZ3d8nK
         19bA3B5YwwN/k43kt2ebOAgZ85lcHLtMdWQGd5wOFQzk6e2r3XtV36Ua8oj/VvnuxNqY
         0a0flha/DvLPnSp8MjgLEZwW4Vp3qiLm/X9gKQHu5uyKXL61TrWbmNyBrf3sjGex0nAv
         2vCkjE19PaPtv99WZGiCxhE9onExZlslvp97KjnumSlJL49Ho24Sy1cgXtyFf0BM3wXe
         bZ5I1h0Bo34iiFrgQVlmMYUL2ZmlhjflDfHoWyMRvMKZkkx+i6FBJuc3IND9giIMHmDS
         hjPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679751258;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eh5aYFqZy2Za1WtYyCdyh5/bECI/l/Vq/asdBbu3I+I=;
        b=uvxDxIMK0q5VjgMoXGhlp1v2lxwohGwnXl6RpIWuBKO0ND2aSZhJntlUPyltjNV3p4
         eCpK7YDqeZiJbqgcujzkHwM9B4B67dj9e8l7E6npSrGH+qua8XLxMaSBc/D9MArXnrTp
         K+BWHIzG9yDDNYqB8c3UHduRo05NOIshslXuBIwYyRprUyph2BCB3TG6wgKoAkNTnb1q
         HYS8BF6cbu/ajejoYw6jpIU+TMTmogIjjySjKR8vP6DaEKwhxV2KqRrYW16ETDulFSYe
         4+cMfGEBTVF/pS0tIAEFdPVjUfo7uGRnMGF78pm1YNiTW9K+bGGv41IfVMi2E+NeY6F7
         MiSw==
X-Gm-Message-State: AO0yUKWWyrzkw7Fmlk5aECHkhKrxaMGIcM++XD2Obfrz25xwiCzSW0Hc
        SndWdFwFw5p2zYdZDx2CLlbd7Lbw4NTNf/H2q8E=
X-Google-Smtp-Source: AK7set/+vgObfunFMTV+k8oA/HkYOXe4/0wVWKN0QliDBFT02YaT0O20SEop4JghBoqwPFyrC+5Nc3md04Co2SLSbfs=
X-Received: by 2002:a4a:d119:0:b0:53b:4e0a:6714 with SMTP id
 k25-20020a4ad119000000b0053b4e0a6714mr2067820oor.0.1679751257849; Sat, 25 Mar
 2023 06:34:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6358:e48c:b0:f6:c472:2ab1 with HTTP; Sat, 25 Mar 2023
 06:34:17 -0700 (PDT)
Reply-To: hitnodeby23@yahoo.com
From:   Hinda Itno Deby <rebender6@gmail.com>
Date:   Sat, 25 Mar 2023 06:34:17 -0700
Message-ID: <CAJ1QMTfu+AbSMc3=5Ta+HagJ8dgcNcEuSy9e13JXkTLvbhjMrA@mail.gmail.com>
Subject: Reply
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM,UNDISC_MONEY,URG_BIZ autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:c41 listed in]
        [list.dnswl.org]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [rebender6[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [rebender6[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [hitnodeby23[at]yahoo.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.9 URG_BIZ Contains urgent matter
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  2.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello

My name is Hinda Itno Deby Please I want us to discuss Urgent Business
Proposal, if you are interested kindly reply to me so i can give you
all the details

.Thanks and God Bless You.
Ms Hinda Itno Deby
