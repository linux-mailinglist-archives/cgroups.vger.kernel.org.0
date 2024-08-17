Return-Path: <cgroups+bounces-4334-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF166955412
	for <lists+cgroups@lfdr.de>; Sat, 17 Aug 2024 02:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EB451F21DEF
	for <lists+cgroups@lfdr.de>; Sat, 17 Aug 2024 00:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2694210F9;
	Sat, 17 Aug 2024 00:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WftZp/GQ"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7198635;
	Sat, 17 Aug 2024 00:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723853718; cv=none; b=Nugf5pKRp14OeKSEPMfdaRvzXKHUPFO4IXvysr8DNNXiU71Adwl2x0TaufU236Hw4ufu66RLFi2S9EU+WzGU2/ExlNfj80jAUD3vI8guxj58hHBupMngkgEQj6VDFZ8Rz/Ld+fgPpqgXKcJAI0AnCEeQj+hmIR1+6Rx927GjvqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723853718; c=relaxed/simple;
	bh=qKNsWf/uh8WL1G91JSSfpXAZmbqLVj4IBxmZ6wPGt4Q=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=mCcl/lbupGTBO2FrCPaRlwv7GoFqWSVDZ+OZBBFI7ZgPUUkLknvqu/QNvM5QdKxsymVElzOyEJ2/Q7M61iBkUhSlnbKyYzsGB6lCJ1utnY2Z0rTdfw9jq7/YM7MlxHbun1ygQ/5c4WBCPo8zMTOwJmrjl7Ro5kZaj+oOWV4/JGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WftZp/GQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61516C32782;
	Sat, 17 Aug 2024 00:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723853718;
	bh=qKNsWf/uh8WL1G91JSSfpXAZmbqLVj4IBxmZ6wPGt4Q=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=WftZp/GQ9G1TlBB7BVagZpxK+9OQug4KfdjDolXwpkWl8rATJm19lpcNlNEqO67GW
	 V5G9pjdZCqQt3/LF+iysfpVbnOdhGH3jGbcP2+zE3VBOYrAZn8hc48KiEvnqLZ8gUH
	 fxDNKH8LAQ6g+dGkzASlQf0dN/ZRs306IJs+mwB5VpAEmGK/awQxFGZJfQmG4Mc3NG
	 DStXQxnpfd1IxIZU0HI7hjpqenZGDIrkcNsld2TzBN99wE+iVlxHkAnOJAXtiNODtO
	 7C8C/QuXSh00opx135sxhWxXEi6hkar/5rPh3Ui0JddCvmGhiaAJIPXW6Sw3QiwGqh
	 IJPJ6aMRrEHcQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB02D38231F8;
	Sat, 17 Aug 2024 00:15:18 +0000 (UTC)
Subject: Re: [git pull] vfs.git memcontrol oops fix
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240816234044.GG504335@ZenIV>
References: <20240816234044.GG504335@ZenIV>
X-PR-Tracked-List-Id: <cgroups.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240816234044.GG504335@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes
X-PR-Tracked-Commit-Id: 046667c4d3196938e992fba0dfcde570aa85cd0e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e5fa841af679cb830da6c609c740a37bdc0b8b35
Message-Id: <172385371738.3661883.5603313870806043821.pr-tracker-bot@kernel.org>
Date: Sat, 17 Aug 2024 00:15:17 +0000
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 17 Aug 2024 00:40:44 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e5fa841af679cb830da6c609c740a37bdc0b8b35

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

