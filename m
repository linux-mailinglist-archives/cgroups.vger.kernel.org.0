Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 888C074C11F
	for <lists+cgroups@lfdr.de>; Sun,  9 Jul 2023 07:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbjGIFla (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 9 Jul 2023 01:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232374AbjGIFl1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 9 Jul 2023 01:41:27 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81773E56
        for <cgroups@vger.kernel.org>; Sat,  8 Jul 2023 22:41:26 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-262ea2ff59dso1597163a91.0
        for <cgroups@vger.kernel.org>; Sat, 08 Jul 2023 22:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688881286; x=1691473286;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oDVdWICwavrWQ8UAVYhe8ynFXsBBW1vVQ7W08zgiq24=;
        b=FyPHf/F/XBBKvloN6yrtynvMhvEmcNUZ1vNSJMiHdSNwk7/uvxYo6FheSjbNpSjcjj
         +TCvwqu29+ipfaD0s65yN8+Ur7kGD5NtuiWoO2XldO8Xsk/8Lo/Fad8rMI/UNXFwOr9Y
         /FMHa/NYew5M1Q//hC7rcfvGDFW/kLzPHVts1XUrUTkQJATjbikG4pj9JgsKZubVgEeQ
         7Y8vCyuNeHzI0WUfpapueWPloU9z7Ga2h/B9lDrkvKfs6k+UAOGyWDHBo819SX9bOr+c
         OesFIYZJXikz6PgPZppV8WABDXT0tbovnJ5gGkeGcje7QxT1s0kfyGCgFoYxibHxoqdu
         b8rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688881286; x=1691473286;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oDVdWICwavrWQ8UAVYhe8ynFXsBBW1vVQ7W08zgiq24=;
        b=L4yOkyq+OaaIGYX40vWZsJ5cpTdM35BQlZE/sBJgvVSqEw1tTIJZVyCcdPpJ+cXyDV
         a5vEMo41Gg4aj/YkoNi6NUcDw7MiAUFUYEqMkkU2soepOhbrFrnnrOGInXPguXg1s/+G
         cNfIovYkXUkbbVLHQUUfQ8Jkt9io9lTHBrL8ctwhkXGWLwSwZdwsqCQBlPLb+G6N9SWJ
         MYXhYI/m7n5F0GfE1YcptnECJ9lyH+I4t5lxYSh2ZsfGCK0ipRvI967F66omSODP9mjo
         nExIvMxqhCE+gHUzD4C23195bFDJnTQ814gcqXtOgIv71Ld8yNJyvf5qS8ScSPYQxfzD
         /Cqg==
X-Gm-Message-State: ABy/qLaJ8gy6fbd/rxXfsPcWelsO+L4XWXJf3rj+gCZC2nNEiAr6AGvU
        smNYajL4NM42oFyEJVkmIeKDWtcTlYj0Q4cGnUw=
X-Google-Smtp-Source: APBJJlH+R8qD6vnKjVCAjpNVmOGYAqdS//pqt7Mis3pZzfssxXqGbXVdo411ajC5WhCfW92DLk+sk9BTA3RYf4zxtFk=
X-Received: by 2002:a17:90b:1a88:b0:262:de82:3001 with SMTP id
 ng8-20020a17090b1a8800b00262de823001mr7315717pjb.37.1688881285812; Sat, 08
 Jul 2023 22:41:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a10:cd06:b0:470:f443:15ec with HTTP; Sat, 8 Jul 2023
 22:41:25 -0700 (PDT)
Reply-To: ninacoulibaly03@hotmail.com
From:   nina coulibaly <ninacoulibaly30.info@gmail.com>
Date:   Sun, 9 Jul 2023 05:41:25 +0000
Message-ID: <CAFb7D3eq1oHHtnE7s05=a0Xza40XEn-8ciNc3Va7YMd=EFHy_A@mail.gmail.com>
Subject: from nina coulibaly
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Dear,

I am interested to invest with you in your country with total trust
and i hope you will give me total support, sincerity and commitment.
Please get back to me as soon as possible so that i can give you my
proposed details of funding and others.

Best Regards.

Mrs Nina Coulibaly
