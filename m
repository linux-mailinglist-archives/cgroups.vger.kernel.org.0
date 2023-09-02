Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F118E79088A
	for <lists+cgroups@lfdr.de>; Sat,  2 Sep 2023 17:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233390AbjIBPiD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 2 Sep 2023 11:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232986AbjIBPiD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 2 Sep 2023 11:38:03 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6FBCFE
        for <cgroups@vger.kernel.org>; Sat,  2 Sep 2023 08:37:59 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-52bd9ddb741so10039a12.0
        for <cgroups@vger.kernel.org>; Sat, 02 Sep 2023 08:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1693669078; x=1694273878; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LqKOi6XeDft6JHIA0q1WMDUlAe87S892KnJGjksHzw4=;
        b=T2+qniJbJMdT6g+lEZ/gRb7HIjv3cAzfQ+3qGNh/H4lQ3Y7KUWDA7vJfRaNPlzd91p
         2YKWnAGlE2wooiWbMc+PKV8irlyqz1eIULvk0d7COUpt+y73oMLRQCwajEm7eEolqH7n
         0TmqXgR67mJPTsK/DscRzhjRcyAJn691d25C4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693669078; x=1694273878;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LqKOi6XeDft6JHIA0q1WMDUlAe87S892KnJGjksHzw4=;
        b=a6hiFkgQrsPeWRc4bslvOvx7aRyRDp/0PJgOD4XvJRlZKaKdJAKFLhiMs0GBK+7LCG
         XxiK53pCjS4GOLgCHWx/ClKKmyzIaWRd/cK9/5BxaBR1h6LpSS0bywkn7sfQWm9zl1AK
         t9Lnl1bDXlg8UFEhJsghefZ/4jo8q1EjfUIUwpZOeAQvlki0SR1UMqt2/nvecJW04LsP
         tlugcq0GorXIFFUJj1kI3WlX4JxzZJf/Cbd9z0wOFC5Zvf8jOo1wXZ9aVRACv7mw2GK9
         KJ7yIUM1wN2Z4VIly0gVvX3q+tbsazSoThgr7F3RxwKEAo2sSvvU7GZJhjmdQH/EDe6A
         nWJg==
X-Gm-Message-State: AOJu0YyU7FLDnFzo8y6dEFx9MszoYPqVN9BQyB5W6vROa7dI76aZ5dnd
        PbZKFIjTe6CMogfvIPkh5dLrpS66ZtGIAaka35O9Eg==
X-Google-Smtp-Source: AGHT+IFXjefLDMQ7HS6BqDwW5IZopC9sjBSC9si8HjqolXdXgqxhifKEiO3S2un/daHV6XpNl9OQYA==
X-Received: by 2002:a17:906:3f13:b0:9a5:bcea:a53a with SMTP id c19-20020a1709063f1300b009a5bceaa53amr3449241ejj.33.1693669077807;
        Sat, 02 Sep 2023 08:37:57 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id ov22-20020a170906fc1600b00992c92af6f4sm3590008ejb.144.2023.09.02.08.37.56
        for <cgroups@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Sep 2023 08:37:56 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-52a1ce52ef4so4021049a12.2
        for <cgroups@vger.kernel.org>; Sat, 02 Sep 2023 08:37:56 -0700 (PDT)
X-Received: by 2002:a05:6402:12d7:b0:51d:d390:143f with SMTP id
 k23-20020a05640212d700b0051dd390143fmr4373503edx.5.1693669076297; Sat, 02 Sep
 2023 08:37:56 -0700 (PDT)
MIME-Version: 1.0
References: <ZPMdTJ7zwrCkdMTu@debian>
In-Reply-To: <ZPMdTJ7zwrCkdMTu@debian>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 2 Sep 2023 08:37:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgmvf9OjxeiO7ZzN2hsmDZ7-HViP9AjQkRN84fuDXNATQ@mail.gmail.com>
Message-ID: <CAHk-=wgmvf9OjxeiO7ZzN2hsmDZ7-HViP9AjQkRN84fuDXNATQ@mail.gmail.com>
Subject: Re: mainline build failure due to d1d4ff5d11a5 ("cgroup: put
 cgroup_tryget_css() inside CONFIG_CGROUP_SCHED")
To:     "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
Cc:     Miaohe Lin <linmiaohe@huawei.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, 2 Sept 2023 at 04:32, Sudip Mukherjee (Codethink)
<sudipm.mukherjee@gmail.com> wrote:
>
> git bisect pointed to d1d4ff5d11a5 ("cgroup: put cgroup_tryget_css() inside CONFIG_CGROUP_SCHED").

I pushed out a commit that should fix it (76be05d4fd6c: "cgroup: fix
build when CGROUP_SCHED is not enabled")

            Linus
