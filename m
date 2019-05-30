Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 180BE30205
	for <lists+cgroups@lfdr.de>; Thu, 30 May 2019 20:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbfE3SgA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 30 May 2019 14:36:00 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38398 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbfE3SgA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 30 May 2019 14:36:00 -0400
Received: by mail-qt1-f195.google.com with SMTP id l3so8227203qtj.5
        for <cgroups@vger.kernel.org>; Thu, 30 May 2019 11:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NeJZLe6Glp9J7ijOwehVSERMU+tv+pK756C0M7/P8rY=;
        b=LH5c+jHYtC/N+vhRvzawOpNggnmoF6NbwY2CU97BaBCtjZxJTMClhmft8uV5EmuO6H
         TG/UFU8+Y+A4eC04mAPCDIZXdHkytFAEuMTMSjz6+CrXbgbCBqzcmWUzp7X8O3RLQ8VA
         QSmBOGEyFDfKF/oaZKAbiHSm7hwv8LLp6THsoRCwkkvC17UehkpcCYd0vBOHpT9ReMUC
         5Fh6/jtG8wlKrQmplkmVhMHp0NOg+uXd8a2gplBFLCF5Fxd+aFkNj6dwykgg3p77w2G/
         XU6UywI4s9oKynhaTFasNidl2RrMgxfS0KkyG96h+aXN0T1H9Cf76I1iRcQq00folJAE
         4yqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=NeJZLe6Glp9J7ijOwehVSERMU+tv+pK756C0M7/P8rY=;
        b=oX6t7Wj185ZZ/H2VAn44Xap7dL5rnbnBLFMaR5i8FmQ/eKelrNPbFRHlPq4rTcIbjO
         67lOvBFJDlJ30p1kM5ed0gKpjVzANn7drVOKYEzwKBsIKYLmlzT5W39LIrgN8z2tpjO6
         jTITw7SBmAvxJA0gn3e7a1dTnJxhJVPErxlzld5qiq8EXGi2234b2Rk/Ur+u6bTUwl60
         b8tnibe88oJtsY+MiS7bwv8imnTj437TC+urf9Iiq8q2WdyQXJK6m/j1bcvS4FrTn/i/
         MvUjFjBv6nnUbGRpehv0TA8aLDEwMQQDaQx9e+qqXiezuoiioPzjJbyWBRLlvbFD61KC
         JKxg==
X-Gm-Message-State: APjAAAXWhz/Kx+R2gS7UxhiBwWNDZITOu75zNNhFTHg+msgUFyIAHrpm
        fgzicNum91JnPK1Avuq40dk=
X-Google-Smtp-Source: APXvYqyaNL+novvrDB7wWuaDMHHKX6zVQ+1SIHTccx//zpegwKyKzVVAlXPBVeGKYCV13BDkHS557Q==
X-Received: by 2002:a0c:c12a:: with SMTP id f39mr4810465qvh.217.1559241358894;
        Thu, 30 May 2019 11:35:58 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:658d])
        by smtp.gmail.com with ESMTPSA id i37sm2142243qtb.31.2019.05.30.11.35.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 11:35:58 -0700 (PDT)
Date:   Thu, 30 May 2019 11:35:56 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Li Zefan <lizefan@huawei.com>, Topi Miettinen <toiwoton@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>, Li Zefan <lizefan@huawei.com>,
        security@debian.org, Lennart Poettering <lennart@poettering.net>,
        security@kernel.org
Subject: [PATCH 1/3 cgroup/for-5.2-fixes] cgroup: Call cgroup_release()
 before __exit_signal()
Message-ID: <20190530183556.GR374014@devbig004.ftw2.facebook.com>
References: <a4ef60d0-5925-c521-b7c6-752219a65484@gmail.com>
 <20190524104054.GA29724@redhat.com>
 <1b882623-8eef-2281-a43e-5086727aa1d6@gmail.com>
 <20190527151806.GC8961@redhat.com>
 <87blznagrl.fsf@xmission.com>
 <1956727d-1ee8-92af-1e00-66ae4921b075@gmail.com>
 <87zhn6923n.fsf@xmission.com>
 <e407a8e7-7780-f08f-320a-a0f2c954d253@gmail.com>
 <20190529003601.GN374014@devbig004.ftw2.facebook.com>
 <e45d974b-5eff-f781-291f-ddf5e9679e4c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e45d974b-5eff-f781-291f-ddf5e9679e4c@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

cgroup_release() calls cgroup_subsys->release() which is used by the
pids controller to uncharge its pid.  We want to use it to manage
iteration of dying tasks which requires putting it before
__unhash_process().  Move cgroup_release() above __exit_signal().
While this makes it uncharge before the pid is freed, pid is RCU freed
anyway and the window is very narrow.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>
---
 kernel/exit.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -195,6 +195,7 @@ repeat:
 	rcu_read_unlock();
 
 	proc_flush_task(p);
+	cgroup_release(p);
 
 	write_lock_irq(&tasklist_lock);
 	ptrace_release_task(p);
@@ -220,7 +221,6 @@ repeat:
 	}
 
 	write_unlock_irq(&tasklist_lock);
-	cgroup_release(p);
 	release_thread(p);
 	call_rcu(&p->rcu, delayed_put_task_struct);
 
