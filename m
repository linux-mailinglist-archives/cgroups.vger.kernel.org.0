Return-Path: <cgroups+bounces-5064-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFD6994734
	for <lists+cgroups@lfdr.de>; Tue,  8 Oct 2024 13:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FCEF1C2627A
	for <lists+cgroups@lfdr.de>; Tue,  8 Oct 2024 11:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA061DEFD0;
	Tue,  8 Oct 2024 11:33:34 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C523FB1B;
	Tue,  8 Oct 2024 11:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728387214; cv=none; b=ji09fVVuyjOnoFhR7CXd9TedFy+lOLn7eRjs9lGX5m2PMvrglBbe0y0+rH3THF6HX9hZUq2Y+3EXs3PQ3MmimENA8PyMGJVNv+qzcbaHUIbbzNiLe6O3BJASclorlozeYD1qj/Tg/jywvBmCIs0RE5r6pZqInDWaZOOpQEw0gKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728387214; c=relaxed/simple;
	bh=Xo5hr2Z/phfzdARgUFAXJIv7Jrg83DR61al9GaBKdDY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sI4y/bKrktAncBtQw7QHWCwzwhuW3Nl4nK0LARYK9U7abMDRwIb3hUS/Meco6eUTSYBjwFBqFjvW5Emxcvx70e8Vq78impZCvjDDw3/2dMv5jgUOlfzjpynqS6M0J4BsMyRngWWTqbYnnhhxgv0ueyvvIxTtdtBFJlNBZnmjGrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XNDRC0Zk3z4f3jMF;
	Tue,  8 Oct 2024 19:33:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 982661A08FC;
	Tue,  8 Oct 2024 19:33:28 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgAnqMRuGAVnI_ERDg--.13677S2;
	Tue, 08 Oct 2024 19:33:26 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: martin.lau@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	tj@kernel.org,
	lizefan.x@bytedance.com,
	hannes@cmpxchg.org,
	roman.gushchin@linux.dev,
	mkoutny@suse.com
Cc: bpf@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chenridong@huawei.com
Subject: [PATCH v6 0/3] add dedicated wq for cgroup bpf and adjust WQ_MAX_ACTIVE
Date: Tue,  8 Oct 2024 11:24:55 +0000
Message-Id: <20241008112458.49387-1-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAnqMRuGAVnI_ERDg--.13677S2
X-Coremail-Antispam: 1UD129KBjvJXoWrtrWUCw15Zr4DAw1UtF17trb_yoW8JrW7pF
	Z5CFW3ta15Cr17G3sIyw429FWfKa18Jr4UWr17Jw10y342vryj9FWI9r1Yqas7tF93G345
	XF9I9ryFk34jvrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
	6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
	xUxo7KDUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

The patch series add a dedicated workqueue for cgroup bpf destruction,
add adjust WQ_MAX_ACTIVE from 512 to 2048.

v6:
- panic when the alloc_workqueue fails, suggested by Michal.
- update note in doc, suggested by Michal.

v5:
- use a dedicated workqueue for cgroup bpf destruction.
- update some messages for TJ's feedbacks.

v4:
- add a patch to document that saturating the system_wq is not permitted.
- add a patch to adjust WQ_MAX_ACTIVE from 512 to 2048.

v3:
- optimize commit msg.

Link v1: https://lore.kernel.org/cgroups/20240607110313.2230669-1-chenridong@huawei.com/
Link v2: https://lore.kernel.org/cgroups/20240719025232.2143638-1-chenridong@huawei.com/
Link v3: https://lore.kernel.org/cgroups/20240817093334.6062-1-chenridong@huawei.com/


Chen Ridong (3):
  cgroup/bpf: use a dedicated workqueue for cgroup bpf destruction
  workqueue: doc: Add a note saturating the system_wq is not permitted
  workqueue: Adjust WQ_MAX_ACTIVE from 512 to 2048

 Documentation/core-api/workqueue.rst |  9 +++++++--
 include/linux/workqueue.h            |  2 +-
 kernel/bpf/cgroup.c                  | 19 ++++++++++++++++++-
 3 files changed, 26 insertions(+), 4 deletions(-)

-- 
2.34.1


