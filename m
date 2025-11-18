Return-Path: <cgroups+bounces-12061-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B993C6A0FF
	for <lists+cgroups@lfdr.de>; Tue, 18 Nov 2025 15:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3188B4FBD68
	for <lists+cgroups@lfdr.de>; Tue, 18 Nov 2025 14:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF373590D7;
	Tue, 18 Nov 2025 14:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d8Pc6zA5"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DDB35C1A0;
	Tue, 18 Nov 2025 14:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763476260; cv=none; b=Jm3f5dwhBLRhc9+8lJcRj/xmqWLc4u+t6p+0NIfmc94l9ERl+afSypz16NjcXXFsQ673w4dzoMzWJay3LkzaWiYxxoC18Q7vHqC3U1gbOa43Tm9JnprMH/wLfhUjLkQsGkKj2DnAWOE5s0AoONejQg8gZ0wdqUkCyi4XxfWQksg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763476260; c=relaxed/simple;
	bh=JWhlaWvpMgMNP0tPPalonhvdEsDwnKfaqbz5u8rhjRg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qB/Bb/8Q5ohEFL6sUsNtbMA/dgD+XJemDcIVhTtLIn7iLhRGkeVDyNXSpXjacxEBR9mD9MCL4C0yjCHHDIE536NYwldOUibFbvy4IYKVzXA3gS0s4X4eFU+q3rF3ziX7DM/AWTEZGPY/UmZkPajv2X2qCqv6Vo7FKLiW6rabtUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d8Pc6zA5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9864CC19421;
	Tue, 18 Nov 2025 14:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763476260;
	bh=JWhlaWvpMgMNP0tPPalonhvdEsDwnKfaqbz5u8rhjRg=;
	h=From:To:Cc:Subject:Date:From;
	b=d8Pc6zA5v4Wv+s8S4ZlVc8Eu1Cf8nxGP5adCAgvNwQtsquFESHUaCzsrkTECYu9G3
	 Wchcco1YNJG0CqVgsYEzjDPeWLSw7VqUJrMQY4u3AbCb2A8l/8Rw+0w50BsS79RaFE
	 jqwIQpkhIjG4VsKCpQWqxnvh8pSXQf8Ale7jBIjUt4v3mMrhgmmTlglLToyykTHPj7
	 747MhB+RaOlxmU7xGELGrkTf9Blzy1TPfdu3WR6scRvb5uZrEMAf3sHZFGp7uRCzvs
	 RJki3Y4Ctxl3CDKwZxh32uE8mT//wCTce+wYVRlGr/1Rj7ONkOcS0bVkXhgQo5tWqi
	 9Q0XffhCGbIsw==
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Waiman Long <llong@redhat.com>,
	cgroups@vger.kernel.org
Subject: [PATCH 0/2] genirq: Fix IRQ threads VS cpuset
Date: Tue, 18 Nov 2025 15:30:50 +0100
Message-ID: <20251118143052.68778-1-frederic@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

See here for previous patch:

	https://lore.kernel.org/lkml/20251105131726.46364-1-frederic@kernel.org/

Changes since v1:

* Remove handling of cpumask availability

Frederic Weisbecker (2):
  genirq: Fix IRQ threads affinity VS cpuset isolated partitions
  genirq: Remove cpumask availability check on kthread affinity setting

 kernel/irq/manage.c | 43 +++++++++++++++++--------------------------
 1 file changed, 17 insertions(+), 26 deletions(-)

-- 
2.51.0


