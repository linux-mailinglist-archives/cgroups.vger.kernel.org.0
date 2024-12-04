Return-Path: <cgroups+bounces-5752-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B72D9E3838
	for <lists+cgroups@lfdr.de>; Wed,  4 Dec 2024 12:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7783416239A
	for <lists+cgroups@lfdr.de>; Wed,  4 Dec 2024 11:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7B01B218B;
	Wed,  4 Dec 2024 11:04:52 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DFD16F851;
	Wed,  4 Dec 2024 11:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733310292; cv=none; b=AzEh0tYoU+NxZny4t8gtR5J64g9pWEzMezveMDjrfgyn0tp7LRi/vYxnZOkuYVQFIsFE1LEXal3ASQ4p6Abruc/QQy1aPJUqIo/C6LtVpF2viLBvuWWayAUSON7OZLbyhh9463XkFtXv7bjhJ25II1LKcm+QI4o2zQYYq9KtDHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733310292; c=relaxed/simple;
	bh=pfdWCCU3zg2HoIKV9BlVcVjxYju5eAMX7FU0CJL+T7U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=p/4xDpL6lhZYfcWx+AQVP+iBzqAWuN2ErCxpEvpFDV6JDESnEWQDHinOYTR5HNfYFBjZn2lDMSX3EI+2Q1SZTZxCG2NmXTpe4WW7cu59j2dQDDAm1Flzm7WosBjTnWzUDX5vlbV3S+yjZE1LcjieXA7VXV9H6k/6mXLHsRf10NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4349f160d62so54606225e9.2;
        Wed, 04 Dec 2024 03:04:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733310289; x=1733915089;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5nWpVhGiEzkzR14cfmahgSoPpiD27clH2JUCpX9Y4GI=;
        b=VMChLEWPK/3Gx4Tl8eAHXY8+KTHb6ktnXG2Y+Ddr0+A81UF9uPKNl3elJxaa6omJlq
         zD+uH5EOEDLVZC0VyJaAFzHfdfoHuL8FyzKMiactkN+3CItPXvpwq3Hj2PdSnl0iTWNg
         a+zgBawJgwLZ7L8nQ6YChMG1r22ToDQVtv5WGNfnf949H+M706enf7sU9pfKlHObG9OY
         PiihAOCYOLtuNjXLV31ITITRjZ+BpVsLXt3+gvC7XhJeXY9DZdpzDDHaPLTDhKVxDanF
         h7MNcS80MCprQ8KegPDAG+uT2wtg9cHYQ6jvmt+qUl8rDd/64l3IvJsz5tVM6zXZqNwN
         KmmA==
X-Forwarded-Encrypted: i=1; AJvYcCVRAt9Lt9D89M59HNM6dlp3V7X4Ql4QpJCblziDjej3TEodk3J/IYv82x38L6MAhrypONnKUk4rkoBPx0DW@vger.kernel.org, AJvYcCXFDCNKs529MjVQ1tZea5Nz8JN0C1XGWPFUKbLmi0GS3EJQzd0k41QbPvXT2e8IZeiLtDJk0PI9@vger.kernel.org
X-Gm-Message-State: AOJu0YyT4SRtgTRQgos1vspw/nLl1RJWyaASMo5e+pg1Aobgn0DuqlVb
	HyfL3XTqGuE/MiuCrbg4Ce5WBobs6EqCzwrP9UPL4QZmtAo03Pjb8+kdrmPjV8A=
X-Gm-Gg: ASbGnct48p80TV2MCFlh1qYDQW06DjWh+lbKB8jqv0iLDj8yaJ9IgpVODC89NEyHWvP
	8g7aF8LiNOLSepdmi/wZ/UQ8I86l+COz8BLzc4+uKLFpod4XfaV3QICy4coZKS2vpXKljvo44gC
	onR0+N7AdNyJefMku86JevmTq1rX/PycQJfZtcOWXewBGPIPpThVtNcmFKnNz/dOhiWylYysd6L
	Pg49edpcdNnTQdJoT0HA6fB08xuuEJfQvfduZBeTxjOuye7N/2WQVVF+VtKpe9fZLs=
X-Google-Smtp-Source: AGHT+IF11i6X+UX63otizZi1hsbf9AYk/HOswsNDjbQusJRV2va98zAhq1wnwgU2U2BVZkKnLxd0kA==
X-Received: by 2002:a05:6000:2aa:b0:385:ef2f:92ad with SMTP id ffacd0b85a97d-385fd3c5699mr5634068f8f.10.1733310288788;
        Wed, 04 Dec 2024 03:04:48 -0800 (PST)
Received: from costa-tp.redhat.com ([2a00:a041:e280:5300:9068:704e:a31a:c135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385de98d618sm15410843f8f.90.2024.12.04.03.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 03:04:48 -0800 (PST)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Waiman Long <longman@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Costa Shulyupin <costa.shul@redhat.com>
Subject: [PATCH v2] cgroup/cpuset: Remove stale text
Date: Wed,  4 Dec 2024 13:04:41 +0200
Message-ID: <20241204110442.348402-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Task's cpuset pointer was removed by
commit 8793d854edbc ("Task Control Groups: make cpusets a client of cgroups")

Paragraph "The task_lock() exception ...." was removed by
commit 2df167a300d7 ("cgroups: update comments in cpuset.c")

Remove stale text:

 We also require taking task_lock() when dereferencing a
 task's cpuset pointer. See "The task_lock() exception", at the end of this
 comment.

 Accessing a task's cpuset should be done in accordance with the
 guidelines for accessing subsystem state in kernel/cgroup.c

and reformat.

Co-developed-by: Michal Koutný <mkoutny@suse.com>
Co-developed-by: Waiman Long <longman@redhat.com>
Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>

---
v2: Address comments

---
 kernel/cgroup/cpuset.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index d5d2b4036314..ee62207fee9f 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -207,10 +207,8 @@ static struct cpuset top_cpuset = {
 
 /*
  * There are two global locks guarding cpuset structures - cpuset_mutex and
- * callback_lock. We also require taking task_lock() when dereferencing a
- * task's cpuset pointer. See "The task_lock() exception", at the end of this
- * comment.  The cpuset code uses only cpuset_mutex. Other kernel subsystems
- * can use cpuset_lock()/cpuset_unlock() to prevent change to cpuset
+ * callback_lock. The cpuset code uses only cpuset_mutex. Other kernel
+ * subsystems can use cpuset_lock()/cpuset_unlock() to prevent change to cpuset
  * structures. Note that cpuset_mutex needs to be a mutex as it is used in
  * paths that rely on priority inheritance (e.g. scheduler - on RT) for
  * correctness.
@@ -239,9 +237,6 @@ static struct cpuset top_cpuset = {
  * The cpuset_common_seq_show() handlers only hold callback_lock across
  * small pieces of code, such as when reading out possibly multi-word
  * cpumasks and nodemasks.
- *
- * Accessing a task's cpuset should be done in accordance with the
- * guidelines for accessing subsystem state in kernel/cgroup.c
  */
 
 static DEFINE_MUTEX(cpuset_mutex);
-- 
2.47.0


