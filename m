Return-Path: <cgroups+bounces-2896-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3532E8C5BAB
	for <lists+cgroups@lfdr.de>; Tue, 14 May 2024 21:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 686D8B21548
	for <lists+cgroups@lfdr.de>; Tue, 14 May 2024 19:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C19181310;
	Tue, 14 May 2024 19:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/F6zMUI"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF807144D0B;
	Tue, 14 May 2024 19:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715714720; cv=none; b=rMpuqaWkN8Tsc6Ps16SyE8GUo3FESFxx9/++bnjKbVkZxqgYRYc+qngM4BLSOukj/L4t3Otio7hmPySVmiIrEPOJo7w3RrUvmHo51lqBOnF8AMNDw/I/h9OCknmwmsUNe5wIUfZUg+sBSmKp2z652lka2YnduQIDCJgZKKUmrEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715714720; c=relaxed/simple;
	bh=BKkPQ6MUtsS8ScL8KN3xo+e8VCvzKFbPixFMlTSPPhE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rs/H3SoH/ExIpe2s7BpkkpJQ32m4jSkG5GjcmgO9KaQn4DJ3L/AycgKf9xnxepqYptU9o7JbLkN+Xq6CU5DJD+yX9js7GHLtwjZAjWeg3TKPeXnfCvlQ0epfYMp9A1IShYAtJjw8Yn6fKESBa9LeAt3Le2VhN8wn9KCatswIrPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T/F6zMUI; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2e3e18c240fso66925791fa.0;
        Tue, 14 May 2024 12:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715714717; x=1716319517; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BKkPQ6MUtsS8ScL8KN3xo+e8VCvzKFbPixFMlTSPPhE=;
        b=T/F6zMUIRJ+CaHt9xzy66G0VOTpHDn80s6tnKcesbNu+0KVPaglK+XOKsgO09SJGL7
         LKSodrLunyd+ElAcxNTTI/lg7z4EW3TxsD/DDRO2qoVIKFLVNqAecUzCsBA8Y8QZq3Em
         cJOuULzXuh3oYOwlGIPi/8LLmqTmv9XqmoF7+y7RhCqmKrLC8xDCITdZarz1guNJ3ljS
         Yw3jjcJyM4BiVUIkb6oDHbiYo+jBMu6YI0dHZHUXZBAsDpSN+AvhP8sbfA7VwbmeoIFX
         sNo1L0d4GPJttod5en5dNnfUTbNn0tmDNTtEmJXP4eg47WVPwqLxPUhF9TU6uy8EAh7H
         50aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715714717; x=1716319517;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BKkPQ6MUtsS8ScL8KN3xo+e8VCvzKFbPixFMlTSPPhE=;
        b=m71qttQKMuAJzIzoDZGrwTs1zzZjB8Cd0OPAf2PzxBtpSJ7PqpU2fXP8VIRKB2uoFv
         Mfs0FTu1o/ALomykI+mrYupsT6Uf5qugCPL929gJ/YD5ZbgSzIce2wYj2Q8x95kcySWL
         MW1nboAxKJEm+6NIMxygvr3q/3k5B8JdlwRrDtUzfpG6bMvRVwAAZr67WVi0FcpjUUrU
         BxtrtD8jJXVUuVCCIMZFEJtSvcgv+3YC6az8+j7wPkWLupzOb9Ez9EocSKRKaguCXc37
         TgY72fsi5jDqdNh9TTPibmVSlYQd/ujrC+bg2korJeUjMCw7ukrPX1AIwMruk0Jq1G26
         gPhw==
X-Forwarded-Encrypted: i=1; AJvYcCVomJc4xUNo1GmjWAZ9pVAGjEp+AWB27VFV3wYpxEXsTsU1O5Yyq5zr7E//0B8NnDGTgqO8URSE9MbIvh0nY6f+Akg27hent04HAcdS+7Le2H3GdiKGwU/RW3uR8W2DBbolRbtVYA==
X-Gm-Message-State: AOJu0YzTqGxvJ4IwdU7Npv1XC0BMFldaGcpwD6j3sHQXHxpvYk22aG5b
	6tM22WxBQXb/68UWYoalv8rX/41CgM7ixgFHVk44aslim6nfvJTy
X-Google-Smtp-Source: AGHT+IGP3P1+UwL6FCmnidu99mpLnYJnZSJQSrp8iNFTaTkPkNeIyLAHQx+RTr4FFfO4iye8vXDULQ==
X-Received: by 2002:a19:6914:0:b0:51f:2f2:d66 with SMTP id 2adb3069b0e04-52210277cbamr11726964e87.61.1715714716487;
        Tue, 14 May 2024 12:25:16 -0700 (PDT)
Received: from dschatzberg-fedora-PF3DHTBV ([2620:10d:c091:500::5:4a5c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-523714d3785sm342275e87.301.2024.05.14.12.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 12:25:15 -0700 (PDT)
Date: Tue, 14 May 2024 15:25:11 -0400
From: Dan Schatzberg <schatzberg.dan@gmail.com>
To: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>
Cc: linux-block@vger.kernel.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: cgroup io.stat propagation regression
Message-ID: <ZkO6l/ODzadSgdhC@dschatzberg-fedora-PF3DHTBV>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Waiman,

I've noticed that on recent kernels io.stat metrics don't propagate
all the way up the hierarchy. Specifically, io.stat metrics of some
leaf cgroup will be propagated to the parent, but not its grandparent.

For a simple repro, run the following:

systemd-run --slice test-test dd if=/dev/urandom of=/tmp/test bs=4096 count=1

Then:

cat /sys/fs/cgroup/test.slice/test-test.slice/io.stat

Shows the parent cgroup stats and I see wbytes=4096 but the grandparent cgroup:

cat /sys/fs/cgroup/test.slice/io.stat

shows no writes.

I believe this was caused by the change in "blk-cgroup: Optimize
blkcg_rstat_flush()". When blkcg_rstat_flush is called on the parent
cgroup, it exits early because the lockless list is empty since the
parent cgroup never issued writes itself (e.g. in
blk_cgroup_bio_start). However, in doing so it never propagated stats
to its parent.

Can you confirm if my understanding of the logic here is correct and
advise on a fix?

