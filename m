Return-Path: <cgroups+bounces-15031-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFVsASTzwmnCnQQAu9opvQ
	(envelope-from <cgroups+bounces-15031-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 24 Mar 2026 21:25:08 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B1AC631C4C7
	for <lists+cgroups@lfdr.de>; Tue, 24 Mar 2026 21:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BF03B30312C8
	for <lists+cgroups@lfdr.de>; Tue, 24 Mar 2026 20:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6F434BA59;
	Tue, 24 Mar 2026 20:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q27bvadm"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC8A2F851;
	Tue, 24 Mar 2026 20:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774383887; cv=none; b=iCWTwTx2YHgYkHxStRedri1QrfVuEVfFs9d7jcwrvPe01vWmiZq7zMN26R2ZiPtSJsW4GkK3Rf5xY+jWowFwaahfn2l/YpLUY4BisWiM82qU53EvQkkGxduVM+p3tCyLQ6fFwtgViu9UfmuKiUZpXa7Ql0xsD0WYEn8ngae3qpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774383887; c=relaxed/simple;
	bh=VmaD37WXPGQSvuLKFT2fUj0oK545HtswXhwSFdPLL0Y=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=RtTcJI4wY+hncOloxfhQfOa3tdREHZleJ4XAtMFzD23I0/Mm1mcsgEGryEXeyM04ebdrdxcMRNUmOc++n3FTSSMXM979UOIFUq6dHoz9hSummoiRa23MMNejnypNxj9Rwr/FhjjhvxDRH3Kc5x+StPLQD18oT7OJS75Ay/gCiZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q27bvadm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAD81C19424;
	Tue, 24 Mar 2026 20:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774383886;
	bh=VmaD37WXPGQSvuLKFT2fUj0oK545HtswXhwSFdPLL0Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Q27bvadm9GzPvu7ILSMzZTKETNMWtYzz7B7V8fcgdJkdkYQFNz82Ul2I96b3GrpVA
	 dTH4ixzjVVobuZDzep52okqXRhAphweaPRKGDnqUc6Yuq/ZSJZsD97KuwE1ja9GQq2
	 NstQ0y7RjHxfLWXQA+9s9TZiPk3RQ5hk3GddWOHUWcJsU3vxbk03w11budhExtHAId
	 MY4otC+aDuk5IRt3cVqloFdWluwoNhO+ZILrwia6bF/fXPQ3YaBCznH7JFIW9TN4aW
	 1KprZUKhQNabw38zj0y7yJypkkX3w3eI27ISA9YzJ9QoyFmfMAHgC69UPUv0LMp5eH
	 /OfVfzlB6KIBQ==
Date: Tue, 24 Mar 2026 10:24:45 -1000
Message-ID: <3ef922c6cca93c9dc6f928394c416d57@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Bert Karwatzki <spasswolf@web.de>,
 Michal Koutny <mkoutny@suse.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH v2] cgroup: Wait for dying tasks to leave on rmdir
In-Reply-To: <20260323200205.1063629-1-tj@kernel.org>
References: <20260323200205.1063629-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[linutronix.de,web.de,suse.com,cmpxchg.org,intel.com];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15031-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SINGLE_SHORT_PART(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: B1AC631C4C7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Applied to cgroup/for-7.0-fixes.

Thanks.

-- 
tejun

