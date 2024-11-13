Return-Path: <cgroups+bounces-5527-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC269C7041
	for <lists+cgroups@lfdr.de>; Wed, 13 Nov 2024 14:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 246D8B2A5D2
	for <lists+cgroups@lfdr.de>; Wed, 13 Nov 2024 12:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D82200CB3;
	Wed, 13 Nov 2024 12:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DlF0XT3L"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A0E200C82
	for <cgroups@vger.kernel.org>; Wed, 13 Nov 2024 12:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731502667; cv=none; b=dqgxWmcv6hLj+3XwNRUe/pYQUSdk750E1MvUjhBuUHUGwE8uxZHjHUvvwNNkg4LAwd8w136RYNvJZXwT4bwlCnb5z2WPlqcbjxea4IhW6RN8Qyp+OBEwAn6xcB72VhNTKP63qP7iLwGWfCFalQX2aqXkV40/snxyjZdZHQWjiZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731502667; c=relaxed/simple;
	bh=Z8cHpr28PWqnrAz+oEPF5D6cFNlxTQjd8wjr0NQW91Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BRTfuxAQ5/Z6xICdnsnDw/ms1TThd/84+Zfy/n5c11ZP/c7OeCmZQMnbfqkmZ6Clo6bYre8B2JOuUjphBwsP1trPYNxPSOUH4SDefbXP2M0ir4gsgjgW0g9yCSofiBCAmOleta6whh1arAvOLDi1lF0VLKU5/yChE+gsuZZxXF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DlF0XT3L; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731502663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DmJ4wu8DbYhc8Pv8vZYpHZ1ZdW4EpmQbe3noGMGjsOA=;
	b=DlF0XT3Lshybk+3t+CskwE732BYeihosSZdpyBAB/Ar0rCv55hEGV2HpK13W9hm3zxKTbD
	+h7zWr0tWMzJP0KbUpEZEdNNxA9DeqF0oVJ7UhsnrArW5FDuZ+OczWBZ2CuLosSPgHE9zC
	6s77MM0HIW1Btg9nX2CMuufuM1XEGAo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-yluOm-EKOeGMAdmFdhP9RA-1; Wed, 13 Nov 2024 07:57:42 -0500
X-MC-Unique: yluOm-EKOeGMAdmFdhP9RA-1
X-Mimecast-MFC-AGG-ID: yluOm-EKOeGMAdmFdhP9RA
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-37d5016d21eso3781727f8f.3
        for <cgroups@vger.kernel.org>; Wed, 13 Nov 2024 04:57:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731502661; x=1732107461;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DmJ4wu8DbYhc8Pv8vZYpHZ1ZdW4EpmQbe3noGMGjsOA=;
        b=FXNlAohLtfWiIyxXfZ3mR5D/VmWgAbLE7cRjXCao9T8VTZASPKZeel0kyDGcI61E6D
         xk0Pn3WAHxwYEDvSfA/6IQMbid4xcuiH8xYX2APqtip8D9I6aZ69RuUkYjtGx4P8oout
         SZIwCrFLOa0yThkNMlq4N4MjmoeqKPq9tCY8y40WJXv3pM8+aQkaTCxoHB1G87oJ/8tJ
         gMKH2KEerKJ4xUCp6rEopOPS5uj/DMMpzPH6RrLWpvhjjxYdK+EYepvkcPVmWWMrLNnA
         yFYhJabizUcgzMUx3vYuQTmTYZWyFmCDZ6b+dzVJb3wjWndBgAGxLiIi7DskhpqX9MdD
         Yt8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUljyTWWW2hXp5qMX0LRbQx+LQvJRWvCtpfKl1JYiYw1IibVWqGG2uqjhFPK4c/bA9McMG9bBN9@vger.kernel.org
X-Gm-Message-State: AOJu0YzWxcFdseDKqbvETe0U05nkfsBa2HTHQxZuzZUNcX89QD7n+PES
	VZWxBiomS9cMKzNvrV+/ofcatWPk7kvQ3muk7h69aJXDgC8yiJOJKRBAgAMAtPqBUcc5J4cLBw5
	T1XgU1XTSIx2qm7zg8BXTCayHc8MLOvjIJkk5KZZuY4oMbJtjnjn3pmU=
X-Received: by 2002:a05:6000:402c:b0:37c:d183:a8f8 with SMTP id ffacd0b85a97d-381f186b35bmr15750518f8f.19.1731502660917;
        Wed, 13 Nov 2024 04:57:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IECeneTw0M0UDknUvW+szkOZ4bQp4iqEGGPv+Sz4EG7o+C84HznYrz6JG/tInCizYIUil6JRw==
X-Received: by 2002:a05:6000:402c:b0:37c:d183:a8f8 with SMTP id ffacd0b85a97d-381f186b35bmr15750484f8f.19.1731502660526;
        Wed, 13 Nov 2024 04:57:40 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-80-47-4-194.as13285.net. [80.47.4.194])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed997391sm18486834f8f.45.2024.11.13.04.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 04:57:39 -0800 (PST)
From: Juri Lelli <juri.lelli@redhat.com>
To: Waiman Long <longman@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Koutny <mkoutny@suse.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Cc: Qais Yousef <qyousef@layalina.io>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Joel Fernandes (Google)" <joel@joelfernandes.org>,
	Suleiman Souhlal <suleiman@google.com>,
	Aashish Sharma <shraash@google.com>,
	Shin Kawamura <kawasin@google.com>,
	Vineeth Remanan Pillai <vineeth@bitbyteword.org>,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH 0/2] Fix DEADLINE bandwidth accounting in root domain changes and hotplug
Date: Wed, 13 Nov 2024 12:57:21 +0000
Message-ID: <20241113125724.450249-1-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello!

This patch series addresses two issues affecting DEADLINE bandwidth
accounting during non-destructive changes to root domains and hotplug
operations. The series is based on top of Waiman's "cgroup/cpuset:
Remove redundant rebuild_sched_domains_locked() calls" series [1] which
is now merged into cgroups/for-6.13 (this series is based on top of
that, commit c4c9cebe2fb9). The discussion that eventually led to these
two series can be found at [2].

Patch 01/02 deals with non-destructive root domain changes. Currently,
such operations do not correctly account for dl_server contributions, as
they are only considered on destructive changes (where runqueues are
reattached to new domains). This patch ensures that dl_servers’
bandwidth contributions are properly re-added to root domains that
remain unchanged, preventing accounting discrepancies.

Patch 02/02 deals with hotplug. For CPU hotplug events, DEADLINE
bandwidth needs verification to ensure adequate bandwidth remains after
a CPU goes offline. The current implementation overlooks this check,
potentially leading to overflow conditions. This patch modifies
dl_bw_manage() to correctly detect and handle overflow situations,
special casing dl_servers' bandwidth contibution.

Please go forth and test/review.

Series also available at

git@github.com:jlelli/linux.git upstream/dl-server-apply

Best,
Juri

[1] https://lore.kernel.org/lkml/20241110025023.664487-1-longman@redhat.com/
[2] https://lore.kernel.org/lkml/20241029225116.3998487-1-joel@joelfernandes.org/

Juri Lelli (2):
  sched/deadline: Restore dl_server bandwidth on non-destructive root
    domain changes
  sched/deadline: Correctly account for allocated bandwidth during
    hotplug

 include/linux/sched/deadline.h |  2 +-
 kernel/cgroup/cpuset.c         |  2 +-
 kernel/sched/core.c            |  2 +-
 kernel/sched/deadline.c        | 51 ++++++++++++++++++++++++----------
 kernel/sched/sched.h           |  2 +-
 kernel/sched/topology.c        | 10 ++++---
 6 files changed, 47 insertions(+), 22 deletions(-)

-- 
2.47.0


