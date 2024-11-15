Return-Path: <cgroups+bounces-5577-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A679CF1B8
	for <lists+cgroups@lfdr.de>; Fri, 15 Nov 2024 17:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABD22B2D595
	for <lists+cgroups@lfdr.de>; Fri, 15 Nov 2024 16:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C671E4A6;
	Fri, 15 Nov 2024 16:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pej/8ATW"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C7F1632F1
	for <cgroups@vger.kernel.org>; Fri, 15 Nov 2024 16:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731688230; cv=none; b=uJTVc8OyCWuTOYBFn1miPFqzULKQCGBgB9qc2fdA32fcTuO8p9RRH5gHtlN2C9bMMq1xOJ+zbBEOk1Ixcmnfqav/veiqld7nYjOD3pyXbAcwoskYDQU+menoJH63KCPPLvav/7cdhxki9kdVASRd5/iUhvYj+Tp9YquNl+VBOSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731688230; c=relaxed/simple;
	bh=23WwRG9YMIrdOINPp98oIY1pU+b7asr/HtZ9Lb7K10Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FR9vdKaJ7zXKKWfbL42dAR3wbFQlaLOJk21Phaylp+HiyWjWVQ19UeRhkONlvBVaEBeIXohK9aqdbqGgKITgusZPPO384058/oqrrqz8l+FQGDrLknjbNf9xcVsTjAg04X53AKNUnn5677ma9hR1ka6lq2hjUa2enz2o9zavvW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pej/8ATW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731688227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=CWuLwX1NW+1DyPKTMhME1vJOYG/j4m1+TWZHBmu4nbA=;
	b=Pej/8ATWMXyvGXMQV5ph14x3hy84hcc/9y0oRChQedhklIP9QVl7o9VXZ0WBJ3rv2Fie1P
	SS55hgUlqUVF6S7V33VyFmnq/dvzIwP1g5iykX9XEF4jAP+s7uSJRhS01hCGitjF9H61TR
	2J3/d10eggc1fENf0aP1wvEgbbXRvZ0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-_xqhR3yMPru6atmXl_Wq5g-1; Fri, 15 Nov 2024 11:30:25 -0500
X-MC-Unique: _xqhR3yMPru6atmXl_Wq5g-1
X-Mimecast-MFC-AGG-ID: _xqhR3yMPru6atmXl_Wq5g
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6cbebfc1725so24709376d6.1
        for <cgroups@vger.kernel.org>; Fri, 15 Nov 2024 08:30:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731688225; x=1732293025;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CWuLwX1NW+1DyPKTMhME1vJOYG/j4m1+TWZHBmu4nbA=;
        b=VXK8CbZ9+RBXUmHnN7LMCRP3NDvMCYaC93j3u+0MOZnLYHrdHCZGn8Umhs+kv/3ZiP
         r7Hix77/4YAwgC7ZcYrT1TeVltOEmfeSQp+lsTINVfs/oCT5eMG7tD2y+fUglCcjfQc2
         M+jqva8U1hWu8hcLdgLsL7AhsXHCPupp2SRhNsgjgqYkARvpTxYydeci5FcNH8CPtJtZ
         Ag1aiAxnOb7T+fqSzYEgswHhxsI1tfHU4SlN8rzeNKrkdd5Zhn6Q01K6OiTYZIKowGT0
         PZM5pd5m4wrhofwnmKNdpsjRRwHT+6K/kjmXsLdjPsdcS421WUMTCg7AOD0EpMKsqnE8
         LAwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLspdhW1XGjKNjvf6/l5hnpZlDu6Z5IFeAzvDQOkPh1lW4wsxqXja4+bPFIJXIVX1FaGcyiTJx@vger.kernel.org
X-Gm-Message-State: AOJu0YwCe/oDG/rJlx2NRg/UQ+t8zc3vYQv1LkhyHkQ9Dh6SX0hg8THH
	6883GdBubyyNvspHTAbUZ9M/RFPgzKgV9wFYULeurvK/Mg0ZEMr5Kj0KH6l2kQ13VqbxsAn7u+O
	zQ20YxTInPEJMjITZhb1DZNHKJpxxLpG6g6j0m5cn06yrnJfCGeyV3KQ=
X-Received: by 2002:a05:6214:3992:b0:6d3:f904:5359 with SMTP id 6a1803df08f44-6d3fb821c77mr44867226d6.33.1731688224822;
        Fri, 15 Nov 2024 08:30:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJdcgA20MMlQvFTg5eHsqs/sPveryXiK7wPJsLZuT6HmgM/b7XQecSuNE+S749+ckIL3iYRQ==
X-Received: by 2002:a05:6214:3992:b0:6d3:f904:5359 with SMTP id 6a1803df08f44-6d3fb821c77mr44866866d6.33.1731688224360;
        Fri, 15 Nov 2024 08:30:24 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-80-47-4-194.as13285.net. [80.47.4.194])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d3ee77386fsm19197606d6.6.2024.11.15.08.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 08:30:23 -0800 (PST)
Date: Fri, 15 Nov 2024 16:30:19 +0000
From: Juri Lelli <juri.lelli@redhat.com>
To: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Koutny <mkoutny@suse.com>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Additional issue with cpuset isolated partitions?
Message-ID: <Zzd3G67_UwBUJaRt@jlelli-thinkpadt14gen4.remote.csb>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

While working on the recent cpuset/deadline fixes [1], I encountered
what looks like an issue to me. What I'm doing is (based on one of the
tests of test_cpuset_prs.sh):

# echo Y >/sys/kernel/debug/sched/verbose
# echo +cpuset >cgroup/cgroup.subtree_control
# mkdir cgroup/A1
# echo 0-3 >cgroup/A1/cpuset.cpus
# echo +cpuset >cgroup/A1/cgroup.subtree_control
# mkdir cgroup/A1/A2
# echo 1-3 >cgroup/A1/A2/cpuset.cpus
# echo +cpuset >cgroup/A1/A2/cgroup.subtree_control
# mkdir cgroup/A1/A2/A3
# echo 2-3 >cgroup/A1/A2/A3/cpuset.cpus
# echo 2-3 >cgroup/A1/cpuset.cpus.exclusive
# echo 2-3 >cgroup/A1/A2/cpuset.cpus.exclusive
# echo 2-3 >cgroup/A1/A2/A3/cpuset.cpus.exclusive
# echo isolated >cgroup/A1/A2/A3/cpuset.cpus.partition

and with this, on my 8 CPUs system, I correctly get a root domain for
0-1,4-7 and 2,3 are left isolated (attached to default root domain).

I now put the shell into the A1/A2/A3 cpuset

# echo $$ >cgroup/A1/A2/A3/cgroup.procs

and hotplug CPU 2,3

# echo 0 >/sys/devices/system/cpu/cpu2/online
# echo 0 >/sys/devices/system/cpu/cpu3/online

guess the shell is moved to the non-isolated domain. So far so good
then, only that if I turn CPUs 2,3 back on they are attached to the root
domain containing the non-isolated cpus

# echo 1 >/sys/devices/system/cpu/cpu2/online
...
[  990.133593] root domain span: 0-2,4-7
[  990.134480] rd 0-2,4-7

# echo 1 >/sys/devices/system/cpu/cpu3/online
...
[ 1082.858992] root domain span: 0-7
[ 1082.859530] rd 0-7

And now the A1/A2/A3 partition is not valid anymore

# cat cgroup/A1/A2/A3/cpuset.cpus.partition
isolated invalid (Invalid cpu list in cpuset.cpus.exclusive)

Is this expected? It looks like one need to put at least one process in
the partition before hotplugging its cpus for the above to reproduce
(hotpluging w/o processes involved leaves CPUs 2,3 in the default domain
and isolated).

Thanks,
Juri

1 - https://lore.kernel.org/lkml/20241114142810.794657-1-juri.lelli@redhat.com/
    https://lore.kernel.org/lkml/20241110025023.664487-1-longman@redhat.com/


