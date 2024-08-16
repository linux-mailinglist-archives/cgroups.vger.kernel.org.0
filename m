Return-Path: <cgroups+bounces-4333-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F3E9553D0
	for <lists+cgroups@lfdr.de>; Sat, 17 Aug 2024 01:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6B251F22C58
	for <lists+cgroups@lfdr.de>; Fri, 16 Aug 2024 23:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2F514601F;
	Fri, 16 Aug 2024 23:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="AXNvZrd/"
X-Original-To: cgroups@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AB7B661;
	Fri, 16 Aug 2024 23:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723851649; cv=none; b=kuSY1Joi/OK0Om5MAfcnohJmbWRdQ3nZNrGZkqhcWGsyU93OYL/IEVnh2lqzowz9Qo5mBs/Ww8yYuX7aDK2aujFRMGcySap8P0AW3kMIeHMV7d0J2/0Mvk7AKYX0RS7TUlyKxLVovR02n6uvGPxpsy2irmrvscusYNU+QlV8hpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723851649; c=relaxed/simple;
	bh=dsl4mVotx8D2zL2Y6j3G/ei5DooiFvfqM/aSIfdYf+o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rhZG8dmtT4IMr1e0tnhYqMixMMRdNz6B3H8eYSUpsKuqwmpbUlKodUy/rJhUK6hOGBSX+r3l1y+DUehJw7M8zFugEgXKYfAfZDTHFpp9w4dyOlUGvLvxORIWr7SzG9P9okGVWumqUyG7/qZo2CE3UKSCIrpPy5+yL/QYSalWRLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=AXNvZrd/; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=iRd/c1+s0/yc1u8kTE+KPRe+NRylYh2FjIP8ffhIXik=; b=AXNvZrd/+8MbJW4K7cEPmc4Dqy
	js3LCE8nKI7+jKHjXQmIoi7lxO3K45Q35a+UYvdO4R+Cd+uLACQbCZhgRm33nkKenukrWxYE5Pezc
	wNXSN99+vOQ82SxZFYFQqCfNa5bCHjdVT/IsR5Zp+Tilydj+0eT4QXBuBN4BSh7MPn6zUsqFcYvxw
	HmigQlVLzrrkMStLiQElDjDkxK2VtjZYxPAFhUMnHdRJsFuhbBOdYNUsiyo39PXj+HK7sflP9kYON
	7NL/55aqBiGMDemVeZlisBXqV/UjZgZk1KSF1dz7XZBkJmc1jNNsV8QLuMsk9JuenVLyCK4RXkhsT
	7061b2Sg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sf6Ym-00000002QdW-2n8C;
	Fri, 16 Aug 2024 23:40:44 +0000
Date: Sat, 17 Aug 2024 00:40:44 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: [git pull] vfs.git memcontrol oops fix
Message-ID: <20240816234044.GG504335@ZenIV>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

The following changes since commit 9a2fa1472083580b6c66bdaf291f591e1170123a:

  fix bitmap corruption on close_range() with CLOSE_RANGE_UNSHARE (2024-08-05 19:23:11 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes

for you to fetch changes up to 046667c4d3196938e992fba0dfcde570aa85cd0e:

  memcg_write_event_control(): fix a user-triggerable oops (2024-08-12 21:58:44 -0400)

----------------------------------------------------------------
memcg_write_event_control() oops fix

----------------------------------------------------------------
Al Viro (1):
      memcg_write_event_control(): fix a user-triggerable oops

 mm/memcontrol-v1.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

