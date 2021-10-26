Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3219E43BE3E
	for <lists+cgroups@lfdr.de>; Wed, 27 Oct 2021 01:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237473AbhJ0AAx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 26 Oct 2021 20:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240362AbhJ0AAu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 26 Oct 2021 20:00:50 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C451AC061570;
        Tue, 26 Oct 2021 16:58:25 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id r28so1188802pga.0;
        Tue, 26 Oct 2021 16:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=caC3B6GjKaBRDDR0pkhw6AqjE4SAmcqhSKEygWuTBsQ=;
        b=pC0e/FlNdelKbXYwhK+ASlyQ5jzvhyztGiS4zvZ3CE59AtXj3P7UhJNSDsDLFS10NW
         bHNo2VacxvFTNet+iaahlaLRCmOFithcpZmhp2Dyl6/b/8R3PoY36vxl2TtQaTNRXdSg
         CuFRnhkffVpMd8G9QXkq6neQkMUYe+9BL2ifcdLaRhxes3I3k6lHoJiYtdrkTSNIGHdB
         wOm86JNvdOCP4sf+lbUiMdF0QWxMcSUi4eCaO9lEI17vbJGK78D7ezdk9pMwhLtYAemi
         pFGdPxjQATyD5onLIo4orkKVqiTxHkB3v4DXyaASas0vdEWlUf/Jn68mZ/q4/949n5OT
         Yhpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=caC3B6GjKaBRDDR0pkhw6AqjE4SAmcqhSKEygWuTBsQ=;
        b=XLYuGcSN2zEfkRjtSi+9ftIfT1WSY2yd8T26XoFU/Rb0S30aDzo+GqCnOfIO+GlxaK
         LfIpHl+v9PDo4z4jjk1Ayq9appi5GitjNh6YCrwPJqtF1HGBQP+VYMsjM7d6ee0UajVr
         TlKMiAAxZPhbDaoDergd2ezu5GCRCMiQ9K9GAH1moDlGQNTmKxoDZA0YntiiEYWoEwky
         G8fUDk21ewReBKt+59b7fbxBKHXzvHO1X/0mCAw5lNpyUBT3wPcsdL7hfTj1E7xz48ju
         J9mZ5fEA/6RN6mS9wyi5UY9phup2rzKEEwPhGfWb+X6wC7PQlMBCD7E9AaX00EHOhAWl
         /5jQ==
X-Gm-Message-State: AOAM533VVxCLR6WEPqxrv4axnpE7RTuzeI/wXVX2m3BCfg8Pgx8fFoWg
        Qj+mDVv24WcL5j/6iiQXHTc=
X-Google-Smtp-Source: ABdhPJz7s3bMcUlp/xqca6cQ1XdJyAoXow5AJAoXehe+hgff4ZpHCA9epMsRBRkni01DuvosT7ZkdA==
X-Received: by 2002:a63:894a:: with SMTP id v71mr18476299pgd.451.1635292705358;
        Tue, 26 Oct 2021 16:58:25 -0700 (PDT)
Received: from barry-HP-ProBook-450-G7.hub ([2407:7000:8942:5500:ba8:d828:5ad2:a935])
        by smtp.gmail.com with ESMTPSA id ob5sm2054823pjb.30.2021.10.26.16.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 16:58:24 -0700 (PDT)
From:   Barry Song <21cnbao@gmail.com>
To:     longman@redhat.com
Cc:     amit.pundir@linaro.org, cgroups@vger.kernel.org,
        dimitrysh@google.com, groeck@chromium.org, hannes@cmpxchg.org,
        joel@joelfernandes.org, jsbarnes@google.com,
        kernel-team@android.com, kerrnel@google.com,
        linux-kernel@vger.kernel.org, lizefan@huawei.com,
        peterz@infradead.org, sonnyrao@google.com, tj@kernel.org,
        vpillai@digitalocean.com
Subject: Re: [PATCH RFC] cpuset: Make cpusets get restored on hotplug
Date:   Wed, 27 Oct 2021 12:58:08 +1300
Message-Id: <20211026235808.34168-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <972a5c1b-6721-ac20-cec5-617af67e617d@redhat.com>
References: <972a5c1b-6721-ac20-cec5-617af67e617d@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

> I think Tejun is concerned about a change in the default behavior of
> cpuset v1.
>
> There is a special v2 mode for cpuset that is enabled by the mount
> option "cpuset_v2_mode". This causes the cpuset v1 to adopt some of the
> v2 behavior. I introduced this v2 mode a while back to address, I think,
> a similar concern. Could you try that to see if it is able to address
> your problem? If not, you can make some code adjustment within the
> framework of the v2 mode. As long as it is an opt-in, I think we are
> open to further change.

I am also able to reproduce on Ubuntu 21.04 LTS.

all docker will be put in this cgroups and its child cgroups:
/sys/fs/cgroup/cpuset/docker

disabling and enabling SMT by:
echo off > /sys/devices/system/cpu/smt/control
echo on > /sys/devices/system/cpu/smt/control

or unpluging and pluging CPUs by:
echo 0 > /sys/devices/system/cpu/cpuX/online
echo 1 > /sys/devices/system/cpu/cpuX/online

then all docker images will lose some CPUs.

So should we document the broken behaviours somewhere?

Thanks
barry
