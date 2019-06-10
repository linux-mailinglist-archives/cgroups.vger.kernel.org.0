Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1115D3B930
	for <lists+cgroups@lfdr.de>; Mon, 10 Jun 2019 18:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389830AbfFJQQY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 10 Jun 2019 12:16:24 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:42152 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389123AbfFJQQY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 10 Jun 2019 12:16:24 -0400
Received: by mail-ua1-f65.google.com with SMTP id a97so1459013uaa.9
        for <cgroups@vger.kernel.org>; Mon, 10 Jun 2019 09:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kXjKVnB8savXZrfkfrTE30N32d5QTWaCVx9N4zDRxzk=;
        b=tB5qVs/5+Wlt5nTQdUbrgqZp5gi8KUH4iiu03a7aDeDFggF6POt91ML+pa7JnEoFGo
         fkRfF/eaI9p37BWzNJD0e4NHmiRPSBYTzrZaqrdvOTAkHOm/igd/grXc/d+koDfmS7BR
         MltcCXm/b9rmWiwgUKzL96nbqaVIEzMrYNiwlLCLr+otQXnbx+1gPpwcHABDQGEyN7Ag
         UEeiGmkvZ40RaccrS+dEUnwAabchsqwXdE6iQyzYEwWJFk5R+m9Lz9lO1CUWPZVi91sj
         +F7rxtWAeHvvWRp4WnhX5ogccsZjtu6dTqHa6EF5ZJwWgIq2zLM0aHvkhwNPw+SFwL5H
         pmbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=kXjKVnB8savXZrfkfrTE30N32d5QTWaCVx9N4zDRxzk=;
        b=gz4MmVysB+XlZ2najPVLffziN6VQnGFizsgyLKCnKm8kgvUlyO7sGX7nykm/SvBqFb
         uv4rDEe4h9+E4SzV0fTtuXPWHVQAIDKdNbucGU2JLqvx6oGuH6iTV4Cr40O/Lk0RK+60
         5Vm+S0kT9CUBcqe3jncEJjq2vTeqeaEv6Q1cp9fx8mikXN0nVyMVlxX3S361+aTGlxzX
         o0w3XUb5oRoGzejIOx7WOYGVsblfT/oWLs5JaECjj9oxNIBf80EhNlrUdFfhA+OcvIMa
         0erAHeat9crZoXcKxRDAS7TkQqTt3Ss8WzaaI6mr2UMLeHXYJlrdP0MGft/KrvhI9x7P
         YOkQ==
X-Gm-Message-State: APjAAAW4P8VcDpH4Ivuc2R4aNdUAkk91xROzsIxRw56tX3CfA+SW1ewM
        B0bQxuMQTR/RoH+hKSPEzac=
X-Google-Smtp-Source: APXvYqxuA47KyuSYcZMkjqe3ge4ko3paQ1V3cdXVMgwtYSnLEuOrWl344sP2GeiB6+ccTAJldA0IjA==
X-Received: by 2002:a9f:2372:: with SMTP id 105mr4064987uae.85.1560183383193;
        Mon, 10 Jun 2019 09:16:23 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:1677])
        by smtp.gmail.com with ESMTPSA id f90sm2479222uaf.3.2019.06.10.09.16.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 09:16:21 -0700 (PDT)
Date:   Mon, 10 Jun 2019 09:16:19 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Li Zefan <lizefan@huawei.com>, Topi Miettinen <toiwoton@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>, security@debian.org,
        Lennart Poettering <lennart@poettering.net>,
        security@kernel.org
Subject: [PATCH 5/3 cgroup/for-5.2-fixes] cgroup: Fix
 css_task_iter_advance_css_set() cset skip condition
Message-ID: <20190610161619.GB3341036@devbig004.ftw2.facebook.com>
References: <87zhn6923n.fsf@xmission.com>
 <e407a8e7-7780-f08f-320a-a0f2c954d253@gmail.com>
 <20190529003601.GN374014@devbig004.ftw2.facebook.com>
 <e45d974b-5eff-f781-291f-ddf5e9679e4c@gmail.com>
 <20190530183556.GR374014@devbig004.ftw2.facebook.com>
 <20190530183637.GS374014@devbig004.ftw2.facebook.com>
 <20190530183700.GT374014@devbig004.ftw2.facebook.com>
 <20190530183845.GU374014@devbig004.ftw2.facebook.com>
 <20190531174028.GG374014@devbig004.ftw2.facebook.com>
 <20190605170333.GQ374014@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605170333.GQ374014@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

Fix for another fallout.  Applied to cgroup/for-5.2-fixes.

Thanks.

------ 8< ------
From c596687a008b579c503afb7a64fcacc7270fae9e Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Mon, 10 Jun 2019 09:08:27 -0700

While adding handling for dying task group leaders c03cd7738a83
("cgroup: Include dying leaders with live threads in PROCS
iterations") added an inverted cset skip condition to
css_task_iter_advance_css_set().  It should skip cset if it's
completely empty but was incorrectly testing for the inverse condition
for the dying_tasks list.  Fix it.

Signed-off-by: Tejun Heo <tj@kernel.org>
Fixes: c03cd7738a83 ("cgroup: Include dying leaders with live threads in PROCS iterations")
Reported-by: syzbot+d4bba5ccd4f9a2a68681@syzkaller.appspotmail.com
---
 kernel/cgroup/cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 9538a12d42d6..6420ff87d72c 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -4401,7 +4401,7 @@ static void css_task_iter_advance_css_set(struct css_task_iter *it)
 			it->task_pos = NULL;
 			return;
 		}
-	} while (!css_set_populated(cset) && !list_empty(&cset->dying_tasks));
+	} while (!css_set_populated(cset) && list_empty(&cset->dying_tasks));
 
 	if (!list_empty(&cset->tasks))
 		it->task_pos = cset->tasks.next;
-- 
2.17.1

