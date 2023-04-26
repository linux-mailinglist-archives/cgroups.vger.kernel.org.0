Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 645966EFC51
	for <lists+cgroups@lfdr.de>; Wed, 26 Apr 2023 23:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239968AbjDZVSn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Apr 2023 17:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239934AbjDZVSl (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 Apr 2023 17:18:41 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E0B3C0B
        for <cgroups@vger.kernel.org>; Wed, 26 Apr 2023 14:18:38 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4efefbd2c5eso5059998e87.0
        for <cgroups@vger.kernel.org>; Wed, 26 Apr 2023 14:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682543917; x=1685135917;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JL3yT3Q33W5/BCQtgOVvz2cK4S2v0dqNTi6RS5aes9g=;
        b=KqbTHGyytrS1BOcngMo4G9Iy3ChDViqTCalIapEZkTkEXW7nHiuyUJZIjzD+8KmjH0
         WNOF8kbphsgcmGhboyq1SoRXrz1fzEChyXHqwDiPLFfff0P+1GmPtt8SiDEqsUD02Tud
         9iWJ5nbnXWoPa3P6ssvuwMEWL6ZDw/66oG95DvHM1eglQE6BdnMaoLka+eSjtzYU1mkE
         UOZtgpROqvdsgW5fIX2zobZ+AuNrNXEX5ZpMNA7t4OgNOVzFHIcjq3BtpwA9FHdMNg7T
         PE5LFKi6cjvxpaAxFgw6yJrU+amKlvktiyJMPy315uiAQBRAogZC6UKZfmQZQfmul2VQ
         Y3AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682543917; x=1685135917;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JL3yT3Q33W5/BCQtgOVvz2cK4S2v0dqNTi6RS5aes9g=;
        b=K7wRC+ZJXQCXXa9+tP8Jm3zQHBUBKX7mMb9PWlXxqkw7Hb5TJkYtpoeb/0UZwInRLE
         hQlcK3+4sJD28Tr4Lya5mwJ68X/jRQoOHGdwLAy5Gcp9y9XrGSghQcJdQzWXGBnOXpX7
         r5kttSbrvJTsQWvFXFdEB095/Gu5nO3PXRA1uxB9fQ4J7iu5zVDsinjtx8iKdq6vsWhS
         9RBY7oZt1zQ6aHndFolDqo3/1jVWwxlCF/fdRir14smjbsSh2OBSWX9uQJn0usdv5QSv
         1wWxUV8/AqY/J6djbnC+Y+URL4AYQXo0H3vrddOtwlwE4tIKuQZDJDv+GcTNxaEbKcay
         6mxw==
X-Gm-Message-State: AAQBX9cxEeubP2jFLACXTc/pD3loUVpAB+RLWoWQFZmYE7I2DfOE/FKY
        q1h3ME2iANIoNwu8Rpbmu570vrMbh1hzbL6VQ28=
X-Google-Smtp-Source: AKy350YHSHTYwidEcijDy90mfl6fJRlNgADO2xI0R6fakCPMbXlPlQ9g3ue4/do6LqnawMNDHXi0+lTf4W4ur4a20NU=
X-Received: by 2002:ac2:5a4a:0:b0:4d7:ccef:6b52 with SMTP id
 r10-20020ac25a4a000000b004d7ccef6b52mr5964589lfn.39.1682543916953; Wed, 26
 Apr 2023 14:18:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab2:638b:0:b0:1b8:330:92a1 with HTTP; Wed, 26 Apr 2023
 14:18:36 -0700 (PDT)
Reply-To: klassoumark@gmail.com
From:   Mark Klassou <charleslucasmake@gmail.com>
Date:   Wed, 26 Apr 2023 21:18:36 +0000
Message-ID: <CAPKQk4Vbvuh+JRhE_mH_Qmsg4qKzcDZA0gJ_q7eMe57zvk22_Q@mail.gmail.com>
Subject: Re
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.7 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Good Morning,

I was only wondering if you got my previous email? I have been trying
to reach you by email. Kindly get back to me swiftly, it is very
important.

Yours faithfully
Mark Klassou.
