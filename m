Return-Path: <cgroups+bounces-8330-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05996AC287B
	for <lists+cgroups@lfdr.de>; Fri, 23 May 2025 19:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB26717A089
	for <lists+cgroups@lfdr.de>; Fri, 23 May 2025 17:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0534297B7B;
	Fri, 23 May 2025 17:21:52 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1721D297B69;
	Fri, 23 May 2025 17:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748020912; cv=none; b=SySp9Uon1E8GhUlVqyatIqSyHlV8ipQCKI2BSJDKvisLowcWmW5U25nxbBbMNZGFYpL7w/2mU1AQixqYT/lqJtSP5uz+Z/FDcRBfIoTaCjRHGNhXk7wWORhnkrppSaf0N4pYJfESZN1iCflOLat8hF4SFkssZk182ESMAyuYN5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748020912; c=relaxed/simple;
	bh=9SLdynl6L7y6joeNZe/hgRVqbliepI84c5Fual0QYhM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XDwezrxxNNtCTEBvMyrl3Dsb64tuFfanqRsx2SCoaMONx3RZmIVFQR2hVPtFI0rZiskcRixKIUDxs6SuIjwfgnhrDszFg8+FGgJQr9bf+jsSYbuewpx/BQ7pYjqCQSvRTVu/imnYi2dfrx7yCNqYvq/EOJfmR3dBjTcniKtLhc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ad53a96baf9so6970366b.3;
        Fri, 23 May 2025 10:21:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748020907; x=1748625707;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1as6ImIdlFWGVqlVEq7SS2UVNO7GhmhlxXbjC8OXbUU=;
        b=OVI4TR30bNaAKlpaW580DlL85Ouo98G777cbZbHU8DAjO/+0Rpt1Jxo/fIbOO8eIbv
         9wUkvFFZEDRXQdpQEov8S2JaSV02II/v34bRNGJ8huGKva9PFRXuMifIAht8W1KQG+aR
         6vsjN0lWNda8uKgkuxwY/asBpR/SQcMPGoMn0oxRhVlxq7GZYTRRX2PFHAlr3eLZ5geK
         MiQJZodC8QjfS+yeKOwcsCcelm8neWTQhoTy037IUy0pCYlS3/CdRmlcRqfKlcCsiyEO
         lsnL5GRjROkTWOVhH/IwnB20oeGJ4+hf09wR4MbLEdbDzVuQ1pWhTX5c2R54Bco4RIG1
         1L6A==
X-Forwarded-Encrypted: i=1; AJvYcCU5Et6SY9LD0RGBCIWFPXYj2u2j5268zuzVVvvCyOQbQkzN5oPPI9mpKj15gOQmwbcWSa8Dn28TkPrmH6C0@vger.kernel.org, AJvYcCW1SqvxUSA7ML3e/6lqLbNScO4pjVdoYSzjsADClOhGdrtkmYCEQK/GA5HYhGzOcw7sp0dFKkhe@vger.kernel.org
X-Gm-Message-State: AOJu0YzrRH3RmlpfMhGMZIN+AIRHe1Zzs1ww25aMye+OtadM1xA9Phj8
	3Dhc4ZlZnjB0Oa7yUubg06gJODUmROg++4UwSuaKxnHc/F6CkfWLafboBawI0g==
X-Gm-Gg: ASbGncu/g5aIs3xVXrkPK6Z5iLcJtBIwg8dZXIVK5gOS9/IzqdfLsXt5i/+qnVUT1GA
	emTdzzINwbUJa6wzCxdcuV0TQKWde1oU0lH6DIAu6kB3g3uEsKesW+S+IZb04Hx5s8pd6gDd3R3
	P7NvXmnIWnlcwnZWtvcLNWa9l4Up9rP4BXJyZFMbFpzA6vB7s/x+m/CKzJA2hybXpbgTTf8In99
	vXm5jPVN00VWYwekNImqcpSD2ftrhhGYHflYIJ3YU1cQbS1xg6+XpJ9Q51RokClljemNiJDzYAa
	EtBMlcdAGPTZ5PaBkHUUnM9PJa7U4qya9Z3zTTiykMY=
X-Google-Smtp-Source: AGHT+IEEWay1bo7xwQtAs3f6A3rSo4pJSW6u6S62+uEQlhJzjpxa/eN/MPuznam0Nb0N36VqDaOo9A==
X-Received: by 2002:a17:907:7d89:b0:ad2:4785:c4ac with SMTP id a640c23a62f3a-ad52d575a9fmr3121280566b.40.1748020906956;
        Fri, 23 May 2025 10:21:46 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:72::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6005ac333d1sm12197258a12.61.2025.05.23.10.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 10:21:46 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 23 May 2025 10:21:06 -0700
Subject: [PATCH] memcg: Always call cond_resched() after fn()
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250523-memcg_fix-v1-1-ad3eafb60477@debian.org>
X-B4-Tracking: v=1; b=H4sIAIGuMGgC/x3MUQqAIBAFwKss7ztBNyTyKhERtdZ+WKEQgXT3o
 DnAVBTJKgWBKrLcWvQ8EMg1hGWfj02MrggEtuyt59YkScs2RX2Mdcy+i62zvaAhXFmiPv81jO/
 7AXG+asRbAAAA
X-Change-ID: 20250523-memcg_fix-012257f3109e
To: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Chen Ridong <chenridong@huawei.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Michal Hocko <mhocko@suse.com>, cgroups@vger.kernel.org, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
 Michael van der Westhuizen <rmikey@meta.com>, 
 Usama Arif <usamaarif642@gmail.com>, 
 Pavel Begunkov <asml.silence@gmail.com>, Rik van Riel <riel@surriel.com>, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=2567; i=leitao@debian.org;
 h=from:subject:message-id; bh=9SLdynl6L7y6joeNZe/hgRVqbliepI84c5Fual0QYhM=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoMK6oTefW5BzotcyUzyayF5x6y5MfHcnenlf2J
 mFeWRdJMYaJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaDCuqAAKCRA1o5Of/Hh3
 bczDD/9jW9atkOFws/9Mw2wEqL09mHhEgwb3LKjbIkp3KBDora5mTdsh4EM6VDEQMdxq1kpjpNz
 GiJtQH7jl1kc71734kzXrt8qJN75Zqyv/pnPjRfRIgAqxKK7UPW/YzanfOzR88LHiUtAbQ8aLV9
 4pbpcytSlqBucL9CaCEGLV1PlWFzdaaBwgzyp3t3LOA3bXJEWVxVtwMGAGB6MA4puNNl+PHzRgr
 8ymf1ID08isRIHU+TNVMyaeqG5EKSgNlcSGjgGYHm4RMBaIQtLI5RZFcrfX4/zZ1WvJznGdwIqu
 gChRgIRKgXT0O/Jz4sKsezfnM9byOY8PuVIydhBnPMTi/B6WQR+HdioIXE92SkS/a/cn2nXpTdc
 tTaPXVLdK8HsEeGrjNlP+ub4dfa387IrUHscHBH9RCoZTa1Vvwmc5sIGSKV3kPD2QJAkEjiZXvS
 CFlJlm5VvP4XcdMvrrcNl9+8iW8/52UIMlvrfXMPherMbhp7cO5Fj7qyF0seL3GtJ0OKUTEl03B
 UfdP2gvmtKfltA6ED/SLIuUrvV0R4kyXmKtHkISbWp5Q72UD1PFy7AyVYovEjPNzCgcwNMWkEbY
 SFHYQAnmna2+xMQkC0N76hbzegoWLAWh2wIIxIwZyzfLgh84GkfNc7yf4RLWJIBwAwSAN7blASR
 tJd2X4lzFEXJ6+w==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

I am seeing soft lockup on certain machine types when a cgroup
OOMs. This is happening because killing the process in certain machine
might be very slow, which causes the soft lockup and RCU stalls. This
happens usually when the cgroup has MANY processes and memory.oom.group
is set.

Example I am seeing in real production:

       [462012.244552] Memory cgroup out of memory: Killed process 3370438 (crosvm) ....
       ....
       [462037.318059] Memory cgroup out of memory: Killed process 4171372 (adb) ....
       [462037.348314] watchdog: BUG: soft lockup - CPU#64 stuck for 26s! [stat_manager-ag:1618982]
       ....

Quick look at why this is so slow, it seems to be related to serial
flush for certain machine types. For all the crashes I saw, the target
CPU was at console_flush_all().

In the case above, there are thousands of processes in the cgroup, and
it is soft locking up before it reaches the 1024 limit in the code
(which would call the cond_resched()). So, cond_resched() in 1024 blocks
is not sufficient.

Remove the counter-based conditional rescheduling logic and call
cond_resched() unconditionally after each task iteration, after fn() is
called. This avoids the lockup independently of how slow fn() is.

Cc: Michael van der Westhuizen <rmikey@meta.com>
Cc: Usama Arif <usamaarif642@gmail.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>
Suggested-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
Fixes: 46576834291869457 ("memcg: fix soft lockup in the OOM process")
---
 mm/memcontrol.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c96c1f2b9cf57..2d4d65f25fecd 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1168,7 +1168,6 @@ void mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
 {
 	struct mem_cgroup *iter;
 	int ret = 0;
-	int i = 0;
 
 	BUG_ON(mem_cgroup_is_root(memcg));
 
@@ -1178,10 +1177,9 @@ void mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
 
 		css_task_iter_start(&iter->css, CSS_TASK_ITER_PROCS, &it);
 		while (!ret && (task = css_task_iter_next(&it))) {
-			/* Avoid potential softlockup warning */
-			if ((++i & 1023) == 0)
-				cond_resched();
 			ret = fn(task, arg);
+			/* Avoid potential softlockup warning */
+			cond_resched();
 		}
 		css_task_iter_end(&it);
 		if (ret) {

---
base-commit: ea15e046263b19e91ffd827645ae5dfa44ebd044
change-id: 20250523-memcg_fix-012257f3109e

Best regards,
-- 
Breno Leitao <leitao@debian.org>


