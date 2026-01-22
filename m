Return-Path: <cgroups+bounces-13354-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uI9aF9BvcWkPHAAAu9opvQ
	(envelope-from <cgroups+bounces-13354-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 22 Jan 2026 01:31:12 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D745FF25
	for <lists+cgroups@lfdr.de>; Thu, 22 Jan 2026 01:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 14C853C03CA
	for <lists+cgroups@lfdr.de>; Thu, 22 Jan 2026 00:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC20726E6F8;
	Thu, 22 Jan 2026 00:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hRNfLhEX"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36B42E36F3;
	Thu, 22 Jan 2026 00:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769041864; cv=none; b=O4VipOZbLEnMMChWZjCNVOdbxS5vKE2HD0gU1iBQdB7Td8AAIoN0EwqoLXdy72CTvBYYnEKXyWGZAOQq9GLPnagNkI0OJOxu+Nw7bHi8Wj6zKWlUqll9k/SSX18fD5B0yUFUCsZhShH4qtpi2gIkDBHBYAjomIBOirEek8JQIDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769041864; c=relaxed/simple;
	bh=9PJyFCSBRSydLTG+PYD+BdETartu0afqKp5zj3dCuAo=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lvixjvSmzMIWzdeEDuM3VUiv3X7IqSOe++ge6MpODU4n6pZ5Q7EnlZ+muyM3p+ZhFxFiI+RjqcL+nHFnMGu1K/OKb8n/InrZ0XlPSiQQNRZGfmIDkPb9A4qssuN5EmsY/uAqqqH6UeN3wPjSswhseVAlJlD9JUB7dY/9IUtamSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hRNfLhEX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8348C4CEF1;
	Thu, 22 Jan 2026 00:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769041862;
	bh=9PJyFCSBRSydLTG+PYD+BdETartu0afqKp5zj3dCuAo=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=hRNfLhEXu/EnVdHVqo49UA9tNPkeIJgfiXjxxVFrxfgYaQhkydT4ezqMlUcGyaqrg
	 NKVkQ7tflTSOMigD8BTTqgVUVOaCVpgYSpWhwFgYdShwO9RQ3HhOXZ7EK+AmQOlbH6
	 iKR+VtkqZ/LoB4y9pfAJsQiLg8cj89uSk7wvF6YTOKLG8CjT7kDjLbWtx/03C6Mkq0
	 NIl0NVKNKGEwXfiVzKjMOHf03LsCTrKQE/02lv+j/TQpP4i23WQcfnqEKkLanjhe1v
	 1i+hftCVnq1491UR6YT5RJ4FkLKx49VUEDeXsu8d9M5ycvEAYDwTZn2iRMMiUbTJJ1
	 r5A7qft1Sc+HQ==
Date: Wed, 21 Jan 2026 14:31:00 -1000
From: Tejun Heo <tj@kernel.org>
To: Orestis Floros <orestisflo@gmail.com>, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH cgroup/for-6.20] cgroup: Remove stale cpu.rt.max reference
 from documentation
Message-ID: <aXFvxF-luw1yJTFQ@slm.duckdns.org>
References: <CAJcPAx1jhjTYods0Kk+bB4kv2L=q3hTeLG-ae+rywd-M2fXtOw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJcPAx1jhjTYods0Kk+bB4kv2L=q3hTeLG-ae+rywd-M2fXtOw@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13354-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 01D745FF25
X-Rspamd-Action: no action

From 0ff6402de70b3233b4df09df9e5072088a993148 Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Wed, 21 Jan 2026 14:24:24 -1000

cpu.rt.max was a proposed interface that never landed in mainline. Remove the
reference from cgroup-v2 documentation.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Orestis Floros <orestisflo@gmail.com>
---
Applied to cgroup/for-6.20. We probably can remove the whole section. Let's
do that some other time.

Thanks.

 Documentation/admin-guide/cgroup-v2.rst | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 28613c0e1c90..9c8888d99e89 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -737,9 +737,6 @@ combinations are invalid and should be rejected.  Also, if the
 resource is mandatory for execution of processes, process migrations
 may be rejected.
 
-"cpu.rt.max" hard-allocates realtime slices and is an example of this
-type.
-
 
 Interface Files
 ===============
-- 
2.52.0


