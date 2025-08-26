Return-Path: <cgroups+bounces-9406-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B09B35266
	for <lists+cgroups@lfdr.de>; Tue, 26 Aug 2025 05:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01FA724180C
	for <lists+cgroups@lfdr.de>; Tue, 26 Aug 2025 03:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FAE72D481D;
	Tue, 26 Aug 2025 03:55:21 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A3E1C5D5E;
	Tue, 26 Aug 2025 03:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756180521; cv=none; b=hWjoVDAfJ4/Hoq0WGj8uYyitxAlPMnWnCPJDDP295rVN5sxxWdAVwkp/eigZFuiLFq1O1tSDCK/ywc2abT7p9wC7viRrC5p/G2X3NsqLUA+IuFZEVWO3o5rCfFRevHQzBQUDEUnQjv4AOdHHIP7dwTYbTogtE/H7vc3KITHGSN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756180521; c=relaxed/simple;
	bh=va+eu6cdZWc24zUsuB0LxwWN+ozjHMlsASTES29Knck=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EUHluHyz60dbmnYX1YcqvFxcNdpeR17yc+Zl5Bfxe83WJrar8f8egJ9MQd7MLa29HMfswCQ9EsNuCvrLiJUiNRK0bwFsk3+SDuNRUMkwrqN4QozDaOPxqYTqWfysiRjYFwhhDynUyH8z1iv68TmdaSP4Q43tDIMbIpZ74rCSahs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4c9v2F3KW7zYQvN9;
	Tue, 26 Aug 2025 11:55:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 030961A0B68;
	Tue, 26 Aug 2025 11:55:16 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP2 (Coremail) with SMTP id Syh0CgCHsJcQMK1o1ZJFAQ--.52077S2;
	Tue, 26 Aug 2025 11:55:15 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huawei.com
Subject: [PATCH cgroup/for-next 0/3] Improve clarity of cgroup destruction process
Date: Tue, 26 Aug 2025 03:40:19 +0000
Message-Id: <20250826034022.1736249-1-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCHsJcQMK1o1ZJFAQ--.52077S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZr17AF15Jr4rKFW8Ar15XFb_yoWfZwc_ua
	4SyFyUtrWxJFW0qay7tFs0qFWY9rWUGFy5JF1ktrWUtF9rXrs8Wan2vrZ8ur10vFs3Jr1D
	Ar9xCrn7ArnI9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbzkYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
	7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UK2NtUUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

This series aims to improve the clarity of the cgroup destruction
mechanism. Since the destruction process has been split across three
workqueues, this patch set introduces helper functions and renames
existing ones to enhance readability. As a result, the logic now follows
a more straightforward one-to-one correspondence, making the overall flow
easier to understand. Besides, patch 1 removes the redundancy online_cnt.

This series is based on 04a4d6c24eef8a1fc89d8b6129ac00ca2f638aff for the
cgroup/for-next branch.

Chen Ridong (3):
  cgroup: remove redundancy online_cnt
  cgroup: add css_free helper
  cgroup: rename css offline related functions

 include/linux/cgroup-defs.h |  6 ----
 kernel/cgroup/cgroup.c      | 59 ++++++++++++++++++-------------------
 kernel/cgroup/debug.c       |  2 +-
 3 files changed, 30 insertions(+), 37 deletions(-)

-- 
2.34.1


