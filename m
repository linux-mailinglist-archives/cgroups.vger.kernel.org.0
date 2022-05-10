Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0595A52155C
	for <lists+cgroups@lfdr.de>; Tue, 10 May 2022 14:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237699AbiEJM34 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 10 May 2022 08:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233994AbiEJM3z (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 10 May 2022 08:29:55 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 110D416D480
        for <cgroups@vger.kernel.org>; Tue, 10 May 2022 05:25:58 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id ch13so4157054ejb.12
        for <cgroups@vger.kernel.org>; Tue, 10 May 2022 05:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=2PM+99QftO/z1hYictLEypVlfT0NcLKaz39PuyU4fT4=;
        b=Acn+B/hnSt7tSuNzLlDc3r/k790B8Ph371iQRYastaqFfVnDwKV03rMx6yh3ngHSj1
         jf6sMrS97ayHgW15YiehH1/FByyzOAolFda1o9UkOHgSUIqfhzo9A7ITbezY5Jw4Mnil
         o8V2vZ2T7yB96zEjWkUuStnOL6LjaWA6fBrjOMp6VM0/3Vm41hqBT+Lu1V3W1E/96QgS
         sVeSkXhh3/gVOonqdBpvLrpnfJrczsKVYG88hO7unXCfKEqzRvtPDRYRIulMp/s9no9L
         bLDzL9o1vmyjDi+hsnxN2383VxQGJXwfjn/T020KzLjEyOiQT9GhNWeu21CPZk2HZfWT
         G7tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=2PM+99QftO/z1hYictLEypVlfT0NcLKaz39PuyU4fT4=;
        b=5SUQMNprav4KkEusqURwZq7rGljmpS8t/S7LmEuQcFi0lO2jWJIq09hYlLG2F2WKsJ
         39wFow4b9qK8zO9QruRigfSU4BqZ+jK6EacNkXHPCGsiD4oYNpaWNU0PKeJ72BVz4DyW
         mGPljVfPB0g/rrfyNzJSWW0JesD2QBTttLvh7Duno8qyCU0s41iwS8D9AfXxdK5H2/tS
         7KmCd/AvdJ76xyVVQ7Ly7UdOFrc2y068yhRu17l4uPz0ZjKy6JR+Elqr/y4KZa/3jiC5
         A7gLYT89s1rqNcdIzqNA8iu0s99HoQmuQIfywTTKg5RD6WBKwXZ5zyDnU9fvjwg/Ogvn
         VwNA==
X-Gm-Message-State: AOAM530By96zIWV15zHLLXlZlXq3w3+uKMC0t5IFfV/L83kqs6/VP+XZ
        PfgWuNomUVteRaNPHfLsPVGr8AO9TS30sYgcWpY=
X-Google-Smtp-Source: ABdhPJzE1rGf8PaSMcuUOMVgQUe6xvRPZ/VeEZMbIpcOv15vpmzKXcFyiWn8viPbp8+Ou4p06l53kwKhur4iUTBPb80=
X-Received: by 2002:a17:906:4fc4:b0:6da:b4c6:fadb with SMTP id
 i4-20020a1709064fc400b006dab4c6fadbmr20139637ejw.282.1652185556409; Tue, 10
 May 2022 05:25:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:907:9005:0:0:0:0 with HTTP; Tue, 10 May 2022 05:25:55
 -0700 (PDT)
Reply-To: mk83770911@gmail.com
From:   Margaret Ko May <joycewanjiku942@gmail.com>
Date:   Tue, 10 May 2022 15:25:55 +0300
Message-ID: <CADm3vZbBH8Pv41uMB1r-ZAxj1MxD93pGvrytkY+cimkVVypj9A@mail.gmail.com>
Subject: Re
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

-- 
I have a deal for you!
