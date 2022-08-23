Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 871AE59E685
	for <lists+cgroups@lfdr.de>; Tue, 23 Aug 2022 18:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244056AbiHWQDX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 23 Aug 2022 12:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244111AbiHWQBp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 23 Aug 2022 12:01:45 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8062F1F40
        for <cgroups@vger.kernel.org>; Tue, 23 Aug 2022 05:13:50 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id m3so13722646lfg.10
        for <cgroups@vger.kernel.org>; Tue, 23 Aug 2022 05:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:from:to:cc;
        bh=EcTgTAfb8gcBa+/RPqk1oum9uIB6i+UE26rEpiqDJWw=;
        b=Sfqz9MwyqtEoqDdxxOaY232OchkRDJcRvZsqBzMVVMcIK11JnJEki4JBfUhz8b2nhW
         eIgy6EufDNDLhD5U57r8F6/Thmw2Qxr5rrYWgpNS5mfGyPk1FdTe1YQdfTzplXAHAl2g
         HVXAgSBSGNEjve1bOuCt+SxWPTmsVqA0FuSxazA54mYJ3D/J7LEYfHLHlvYnmoD5ZD3E
         ictZwOVsV/Vt8g7TpZH8c8MPpsV9jp529DTsavyst4DIQ6aCbqq84KJ+b4YqWOZEpRCQ
         /mgjxjBVJ1cw36UvlxggYxTkfMFFbafh73hBhSypFAwtEEyXDW2QXqSixN9+eT7904TJ
         pgNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:x-gm-message-state:from:to:cc;
        bh=EcTgTAfb8gcBa+/RPqk1oum9uIB6i+UE26rEpiqDJWw=;
        b=26p+fwa/R64Zx/NbG75o4PxP53jSj1BT5rkdO0Ux/OnPMDCIeB9LDwqite93VUXeGX
         Jsjvzmp3FdQhWA4BhNLKuaSN+19Q0V3Tc4G/MXYJ5xzaRlpioZV17+yU5MHvRW400gS4
         O9QxD8V6RwB5WV4huMnRmVQqY0kjEp6Pzw3/1Z7CnDTS7qNm6NXYpb1d+eoriiJHRKxz
         MKzKEEK66SD1+TTYN1uhSIwvpFy+nM5LnlDXyrJAmEdgFmv2MoU6kfPJ5p0ktZqq8hRL
         n9EPo570fUxeMIwu2ofA+n8FHDux+O4H05Xxi5iXkYxeyMkdu7ZUi3cOBeKA3MEBH/My
         6PRg==
X-Gm-Message-State: ACgBeo2j71FhZcxbO9CBTXBDIwlJUA2HdicDBfc10kAUneb1DBBBuW8h
        +2bNmxNDxQR0WpDAiS7ws9bjJDSutY6ZJw==
X-Google-Smtp-Source: AA6agR6xLjtJ2pObMjwgOpnlyYxxZTaVVFn9tiFbCVxilYq3ldk6rlJWe02Nj2VUjlq+OnW0Ur4fqA==
X-Received: by 2002:a05:6512:308c:b0:492:e45a:4310 with SMTP id z12-20020a056512308c00b00492e45a4310mr3172973lfd.22.1661256811599;
        Tue, 23 Aug 2022 05:13:31 -0700 (PDT)
Received: from smtpclient.apple ([89.21.157.196])
        by smtp.gmail.com with ESMTPSA id g5-20020a056512118500b00492f1755d8bsm553937lfr.243.2022.08.23.05.13.30
        for <cgroups@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Aug 2022 05:13:31 -0700 (PDT)
From:   =?utf-8?B?TWF4aW0g4oCcTUFYUEFJTuKAnSBNYWthcm92?= 
        <maxpain177@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: cgroups v2 cpuset partition bug
Message-Id: <C98773C9-F5ED-4664-BED1-5C03351130D4@gmail.com>
Date:   Tue, 23 Aug 2022 15:13:30 +0300
To:     cgroups@vger.kernel.org
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SCC_BODY_URI_ONLY,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello. I have no idea where I can ask questions about cgroups v2. I have =
a problem with cpuset partitions.
Could you please, check this question?
=
https://unix.stackexchange.com/questions/714454/cgroups-v2-cpuset-doesnt-t=
ake-an-effect-without-process-restart=
