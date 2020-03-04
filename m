Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 312521794C3
	for <lists+cgroups@lfdr.de>; Wed,  4 Mar 2020 17:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbgCDQQV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Mar 2020 11:16:21 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44622 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbgCDQQV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Mar 2020 11:16:21 -0500
Received: by mail-qk1-f196.google.com with SMTP id f198so2137986qke.11;
        Wed, 04 Mar 2020 08:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OEItHJAQEWgalgushQTyB6lGoSgH6c+Ihc2zlQhimRs=;
        b=iJ1CkyFBT9pLUqQUYEJHfFfgobiSXkCa+gyEfu/r3m/nYu56CBIc7Cmo/JYsEAaGZY
         ba9/Ekd3G41hhc/4iiI/n4g0XusrQmPo+SxgGdUWZy2n9lx3I9ZXwkx04MCXqzlU4ka4
         XQHuzeA39YDcvWJiFXA2ci723xtXQ+zb3+/5mqPAJQrnnNpL65UjmYc0eGLJFkyswMVj
         eGdu2sd9zNi0KhNe0VuHjb9/dXmpJL6hL7oBxOgexpS/3Wq25Y6+IvFJuEHpnJ/DjeZH
         7JnJGAE1EWOs+MNiyDYfg9aT3r/JGukHN6Em5A24jD3em2tJ2bHSloYD9bSjubUo6ZlB
         D5fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=OEItHJAQEWgalgushQTyB6lGoSgH6c+Ihc2zlQhimRs=;
        b=i89f/sG8iBkckCtUHMVaSGNlzvkW5zcS+E97MIPOnmDyuKWQ/A5GI7tJ3BdkKfXJH6
         zYWwK1dVGCfFbUiiLSHTj5bYZR/w36Mti3ksOb/VbdEfXT6zxF0+IeiZLDTObehUsrdL
         HYiua9bS8ibEKWlFHBMTyM3ssv8RtZ1m8DzJuGEYXeWtZI41Sk0rMkKG5K2nb9/AAfjQ
         nZ2zsM/QJwSd1KelXlxv/HK5esBMAtzDtByu/4Flt1Z1iZihSEdnjZvqfRzd8x3OpPe+
         Rnbo5hhIrlauJbonFYSpxwXIzawrTjHRhN60LER4RIUxdKW8YSAhPOOREVoAXAgiWm7M
         3AbA==
X-Gm-Message-State: ANhLgQ1HiHj4AbwAItOrkkwHTJLQRPBwAqXjekyhZWSVSmaqkDY1EPAo
        0VA3SB3GjsgqHbD233xZJp4=
X-Google-Smtp-Source: ADFU+vvjS5Q+6TpvZEpQtf1e0+PPHAHCq43eI83KlbwBgh1HexC8reJg9uIMN+Y3Hx3wovDAvkpg6A==
X-Received: by 2002:a05:620a:691:: with SMTP id f17mr3593366qkh.342.1583338579447;
        Wed, 04 Mar 2020 08:16:19 -0800 (PST)
Received: from localhost ([71.172.127.161])
        by smtp.gmail.com with ESMTPSA id o16sm1363436qkm.68.2020.03.04.08.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 08:16:18 -0800 (PST)
Date:   Wed, 4 Mar 2020 11:16:17 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     lizefan@huawei.com, hannes@cmpxchg.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: fix psi_show() crash on 32bit ino archs
Message-ID: <20200304161617.GD189690@mtj.thefacebook.com>
References: <20200224030007.3990-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224030007.3990-1-cai@lca.pw>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun, Feb 23, 2020 at 10:00:07PM -0500, Qian Cai wrote:
> Similar to the commit d7495343228f ("cgroup: fix incorrect
> WARN_ON_ONCE() in cgroup_setup_root()"), cgroup_id(root_cgrp) does not
> equal to 1 on 32bit ino archs which triggers all sorts of issues with
> psi_show() on s390x. For example,
> 
>  BUG: KASAN: slab-out-of-bounds in collect_percpu_times+0x2d0/
>  Read of size 4 at addr 000000001e0ce000 by task read_all/3667
>  collect_percpu_times+0x2d0/0x798
>  psi_show+0x7c/0x2a8
>  seq_read+0x2ac/0x830
>  vfs_read+0x92/0x150
>  ksys_read+0xe2/0x188
>  system_call+0xd8/0x2b4
> 
> Fix it by using cgroup_ino().
> 
> Fixes: 743210386c03 ("cgroup: use cgrp->kn->id as the cgroup ID")
> Signed-off-by: Qian Cai <cai@lca.pw>

Applied to cgroup/for-5.6-fixes.

Thanks.

-- 
tejun
