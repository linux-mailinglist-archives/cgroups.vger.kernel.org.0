Return-Path: <cgroups+bounces-3906-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD95D93CDC7
	for <lists+cgroups@lfdr.de>; Fri, 26 Jul 2024 07:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 742CF2830D9
	for <lists+cgroups@lfdr.de>; Fri, 26 Jul 2024 05:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485CB39AFD;
	Fri, 26 Jul 2024 05:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="TzTbVFu2"
X-Original-To: cgroups@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E26A34;
	Fri, 26 Jul 2024 05:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721972641; cv=none; b=XnC3L0dJhIoDcOHl3u2ykezxSOy8sNSaRhiuCK4GAAPn+yNaQtoH32akl56fWjG3xQh3Y869c51dY8fMgEMNDgdcGWU1F2caFVFU57zL18pon8IdXlfBUDWk4IVebu+WyhmbFmnWPk5NkxSB8xXFb1JV3z7zgVcEgD+qMD6zPSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721972641; c=relaxed/simple;
	bh=j8GUJpwBa+53YQgHIvrd+zWNwwWoCWaZpJiWO677IT4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GJjJYkgd68baXxGYr5PSEyqpV+McOjPZ31Cy3k0ZhVFU9ix7Ldaf2H/2SmfBh1Cap6WYoWvPLuV7Tx/nh+NybCarXHIE3lnYmvR2u/iA48tsrYXyglm20QotGELGDRZXzpganGv/3HvBQZYf4BXitcXZun1O39V2H4GVyqg5Z7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=TzTbVFu2; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=AFJ3Q2jLJUrIGw3izxFHTLqO09jmXVjZH/rtp3dbQJM=; b=TzTbVFu2HGCK+X7O6r/QvJ3SBz
	Gg6kUsFpF+SX+CuHoCa880L2uaNV4lBRpNAdu48QFaqUs+BBmtIG79dSAqoHNdPGW3BJjraOliFSX
	oHV8jMUpIOehdk5QXRzBw5ay8/j12p5+Sjh4vHzq8M6wodMJD5MlcamEeklAR29AnwarVflDISNU+
	T6XBAMwEAJHh+8eZMlvdcZIm/mV0pfvldIvo76COEtu3mva8BfUx0tzKuSPcE7onzkD72xSqBpDUU
	HDipQ3fk6MhOaMoDaOxgfOLFVi0GGNM0ffbqvXO8pmWqCGrYpARjrfTw3ImlS9+jpGhOmQRO9KAdI
	m9U9zJLA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sXDkD-0000000297w-0nWy;
	Fri, 26 Jul 2024 05:43:57 +0000
Date: Fri, 26 Jul 2024 06:43:57 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: cgroups@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] memcg_write_event_control(): fix a user-triggerable oops
Message-ID: <20240726054357.GD99483@ZenIV>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

We are *not* guaranteed that anything past the terminating NUL
is mapped (let alone initialized with anything sane).
    
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 2aeea4d8bf8e..417c96f2da28 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -1842,9 +1842,12 @@ static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
 	buf = endp + 1;
 
 	cfd = simple_strtoul(buf, &endp, 10);
-	if ((*endp != ' ') && (*endp != '\0'))
+	if (*endp == '\0')
+		buf = endp;
+	else if (*endp == ' ')
+		buf = endp + 1;
+	else
 		return -EINVAL;
-	buf = endp + 1;
 
 	event = kzalloc(sizeof(*event), GFP_KERNEL);
 	if (!event)

