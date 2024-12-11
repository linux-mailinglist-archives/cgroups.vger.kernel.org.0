Return-Path: <cgroups+bounces-5822-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 229EB9ED6D0
	for <lists+cgroups@lfdr.de>; Wed, 11 Dec 2024 20:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 938F918848AC
	for <lists+cgroups@lfdr.de>; Wed, 11 Dec 2024 19:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7CA1FF1AC;
	Wed, 11 Dec 2024 19:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bz+Jgs49"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D50F2594BD;
	Wed, 11 Dec 2024 19:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733946764; cv=none; b=YYQrTp00sEQLmzZi9cHFqHJvQ0VtXcmQSOsM2KpbRP1iB0d9pnzCEXsVyzuqvmBYDW4hWUkRl7ryk1mP8EigkwCR39vfcsDEKe/iJbDtPCdRqn+6aGLa7yCJLTeMjvrubtzDVTk1unPKlVKk1tdA26d5F6Rs5zoOpUzdoZvLhs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733946764; c=relaxed/simple;
	bh=DRkT/ICGD06dt0w7jyVeMGiS/xoEd4Fr+/dZnoSLR5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nIdLDHIwqxjgF6UpOKdzHJ9Qo02/8wrM5dfCKR7NaO4sLNr/U7ZYHCNy3gBcVsd4zP+Fxx5tZhSUxDZ1NiYxd3KSbqLcQDKbKBVk5nnhr05IqznGIJb9OStNCMyJpqdhLsGmULyc1tTKq0cXLunnSt0v3/20S1zyO/FkNmC1IOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bz+Jgs49; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76528C4CED2;
	Wed, 11 Dec 2024 19:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733946763;
	bh=DRkT/ICGD06dt0w7jyVeMGiS/xoEd4Fr+/dZnoSLR5c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bz+Jgs49p18O+904xYURH0C2NV43Fw8hOE2UM4HBKIClxpQaGiM8wpIN0gHshRkF8
	 8JKz08nS+Cu1uVPevDvzrIM9AuNqro2I6QN1jDK+XmJ5LxDdeZSP/TBlHAkm965EPZ
	 ubgw251uC95seI0heVJEKfYrJKO4zhUVtGoWc89LrSnAsi+hrLIn0LU6ZUav4uLnXY
	 ekr8UEE4nuuRJXEpa8IcN6+xXSZueumtKpPRM374iZg5XDlxrkalV3aqoLHtg74lzH
	 sIb6x+KD5oL30EI+PoI8bTaK4F1V+5HpD4ikBXSBX6Rfrw5PM19/eOobQ2JmUn3EQq
	 TV2gqwdDbrvZQ==
Date: Wed, 11 Dec 2024 09:52:42 -1000
From: Tejun Heo <tj@kernel.org>
To: syzbot <syzbot+31eb4d4e7d9bc1fc1312@syzkaller.appspotmail.com>
Cc: cgroups@vger.kernel.org, hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org, mkoutny@suse.com,
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [cgroups?] general protection fault in
 __cgroup_rstat_lock
Message-ID: <Z1ntik1F3Fy5Zpvn@slm.duckdns.org>
References: <6751e769.050a0220.b4160.01df.GAE@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6751e769.050a0220.b4160.01df.GAE@google.com>

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-6.13-fixes-test

-- 
tejun

