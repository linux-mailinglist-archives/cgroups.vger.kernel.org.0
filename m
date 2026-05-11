Return-Path: <cgroups+bounces-15724-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WAYcMIWYAWomfgEAu9opvQ
	(envelope-from <cgroups+bounces-15724-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 10:51:17 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B0C50A5A7
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 10:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE1BF30AED2D
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 08:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963083BED56;
	Mon, 11 May 2026 08:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EHSosQNW"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69423C872B
	for <cgroups@vger.kernel.org>; Mon, 11 May 2026 08:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778488567; cv=none; b=H7lmQkfSgpbcLkGPXtT1PpLchWjm9RmS6R6dXYJ7ymAq8TS5ALiJfkgtr8DkNGLnoT8Q7dib0eY+wPnYR0ew5fE57Y47PlNZ8ip4PgE0soL2lXbj7vx+BsndWhLU+lS+LK0TvDso1EnIEsL8cJy2ivn9M81IQlZLnhVbyvkeXag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778488567; c=relaxed/simple;
	bh=/EBK9Za3dzKeST6xzL+uhXsqga85E68iUDnkuLoGL9Q=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=iFx8BvmxI7ZAvmOFRCvfR8BDrXMyKvAdj+20+P2VQ4PcUP7/HQwXIY+dLrrEdu9tq4UJbiopUun+/h33dDOMlHd4c/6FmLDuC+VegDQOINpJKk/A7Z3yHy9w894F33oxAHrezXraPIx0/xTJ7PZ8WAZ5Qv52lfejqOUsU5fLpsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EHSosQNW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1484DC2BCB0;
	Mon, 11 May 2026 08:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778488565;
	bh=/EBK9Za3dzKeST6xzL+uhXsqga85E68iUDnkuLoGL9Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EHSosQNWCAyeUiTyCCE3Q9c7AIySd6FQcEdzoIb9PTz3MQoRRuY7xmShz8a/escLC
	 9j6tWffwcqd/tPt2tHM3D/OUiu2PFl2z0SPHhW24xPgg+E+ao9+S7iDlRJGq7n9w05
	 x7E71p9/OzBKWokFFoQbLXPAwYbZmrzYN7Otvs3uETXb6tgGujGaCVGgGq+dqJBxcz
	 0cPr2RRbJUXXoApw0woGLzqTg6ytZxahyH7fFTu8vIyTDw312Mt2huarP52xMAuxIs
	 /RcNg6a1529dAEAO8T97n8oozgam4uukwcWmEQeE6/p5ZoSdDdCZoCpaafZa+F3s0I
	 m+7QYAEuV++Aw==
Date: Sun, 10 May 2026 22:36:04 -1000
Message-ID: <2d0dbeae9e3bfa4a5006964c38d2edda@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Tao Cui <cuitao@kylinos.cn>
Cc: hannes@cmpxchg.org, mkoutny@suse.com, shuah@kernel.org,
	cgroups@vger.kernel.org
Subject: Re: [PATCH] selftests/cgroup: fix misleading debug message
 in test_cgfreezer_time_child
In-Reply-To: <20260511062520.256160-1-cuitao@kylinos.cn>
References: <20260511062520.256160-1-cuitao@kylinos.cn>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 50B0C50A5A7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15724-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello,

Applied to cgroup/for-7.2.

Thanks.

--
tejun

