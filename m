Return-Path: <cgroups+bounces-2894-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4D18C5AA7
	for <lists+cgroups@lfdr.de>; Tue, 14 May 2024 19:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F7E01F23250
	for <lists+cgroups@lfdr.de>; Tue, 14 May 2024 17:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D351D181BBA;
	Tue, 14 May 2024 17:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iM6ihLKH"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C86181B87
	for <cgroups@vger.kernel.org>; Tue, 14 May 2024 17:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715709225; cv=none; b=PF1KkkA7rhI6i2RdlgSJmD4+NrG6rnaFnLqjF8AtbiIEtOxm0EmVhXceSq/CKxj4w/Qr92Z2VDN/dtySGTRVVe6iFegleUOSc0qyvjMZsOR3/DVYb5mA8NfDc2dB1VRhxksIyVOSUPjgUndAcBrgkquEAyP1msJfVYJp1gpLtLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715709225; c=relaxed/simple;
	bh=29Ogzu8HUgDu3PF9FKvjcGb+SavKhmrv7g+xDkNBUkY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-type; b=Aeadf3/GiVFWMtxD0UquNYLA8DcxAN+v2doVsLprgqHL3lI2lu7WHswgMvDX6JF+95pMJqGbvt0ux/KBaebIQ0NdWZzGc0TrHQ1uhjt1DqhfHz03k495oIjIE1BQPxHoWFU4POyfuWEs9pBGBlxHM/9n4yJVvveRPMPa3YVImQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iM6ihLKH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715709223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J8WReQiv4GBqlDuegj32JcgtpHrEsWG68ox5pprOL3Y=;
	b=iM6ihLKH7eYAjLy1XsNjwFhh6EX9Tj3O4JDLIcBr5Z6PpnySwwzOCLkBEZPVu+YGKsGwE2
	wfkIHKKWm/wpFkTXKaavsN+X4134xrKuSPKYcm7ntBwj68MKCaUdjUjh9xM196RejnUwBQ
	LmkQDhJjChdWa+4xq/vwPVntBHvd6uQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-494-qrfXvdWFNuuPCZl6fv1CTg-1; Tue,
 14 May 2024 13:53:36 -0400
X-MC-Unique: qrfXvdWFNuuPCZl6fv1CTg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E2D1229AA2C9;
	Tue, 14 May 2024 17:53:35 +0000 (UTC)
Received: from jmeneghi.bos.com (unknown [10.2.17.24])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A433A400057;
	Tue, 14 May 2024 17:53:34 +0000 (UTC)
From: John Meneghini <jmeneghi@redhat.com>
To: tj@kernel.org,
	josef@toxicpanda.com,
	axboe@kernel.dk,
	kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	emilne@redhat.com,
	hare@kernel.org
Cc: linux-block@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jmeneghi@redhat.com,
	jrani@purestorage.com,
	randyj@purestorage.com
Subject: [PATCH v4 6/6] nvme: multipath: pr_notice when iopolicy changes
Date: Tue, 14 May 2024 13:53:22 -0400
Message-Id: <20240514175322.19073-7-jmeneghi@redhat.com>
In-Reply-To: <20240514175322.19073-1-jmeneghi@redhat.com>
References: <20240514175322.19073-1-jmeneghi@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Send a pr_notice when ever the iopolicy on a subsystem
is changed. This is important for support reasons. It
is fully expected that users will be changing the iopolicy
with active IO in progress.

Signed-off-by: John Meneghini <jmeneghi@redhat.com>
---
 drivers/nvme/host/multipath.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index e9330bb1990b..0286e44a081f 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -67,6 +67,10 @@ static int nvme_activate_iopolicy(struct nvme_subsystem *subsys, int iopolicy)
 		}
 	}
 	mutex_unlock(&subsys->lock);
+
+	pr_notice("%s: %s enable %d status %d for subsysnqn %s\n", __func__,
+			nvme_iopolicy_names[iopolicy], enable, ret, subsys->subnqn);
+
 	return ret;
 }
 
@@ -890,6 +894,8 @@ void nvme_subsys_iopolicy_update(struct nvme_subsystem *subsys, int iopolicy)
 {
 	struct nvme_ctrl *ctrl;
 
+	int old_iopolicy = READ_ONCE(subsys->iopolicy);
+
 	WRITE_ONCE(subsys->iopolicy, iopolicy);
 
 	mutex_lock(&nvme_subsystems_lock);
@@ -898,6 +904,10 @@ void nvme_subsys_iopolicy_update(struct nvme_subsystem *subsys, int iopolicy)
 		nvme_mpath_clear_ctrl_paths(ctrl);
 	}
 	mutex_unlock(&nvme_subsystems_lock);
+
+	pr_notice("%s: changed from %s to %s for subsysnqn %s\n", __func__,
+			nvme_iopolicy_names[old_iopolicy], nvme_iopolicy_names[iopolicy],
+			subsys->subnqn);
 }
 
 static ssize_t nvme_subsys_iopolicy_store(struct device *dev,
-- 
2.39.3


