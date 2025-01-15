Return-Path: <cgroups+bounces-6174-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25ECCA12ED3
	for <lists+cgroups@lfdr.de>; Wed, 15 Jan 2025 23:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 457EB188588E
	for <lists+cgroups@lfdr.de>; Wed, 15 Jan 2025 22:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C451DD0C7;
	Wed, 15 Jan 2025 22:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IKkojfCg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SAcPDqWa";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="itJOJthg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MMZ217R8"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74BE1DC9B3
	for <cgroups@vger.kernel.org>; Wed, 15 Jan 2025 22:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736981981; cv=none; b=OKxgA9k8rLpP0/8kFRujpDlG0A6IGs5Kq5DvUL5hExLSGsk72lMwtHMG/YyonR17hfS0koDff9lTUdYOMSC2DGK4JJkp6sBQo8XwpQDFJ0bc/H4HGuBBBmiehmt3shxbtKCO5EXxCvyj9L8N2Y1o9AebfmXh7nh88TwPNDUVLhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736981981; c=relaxed/simple;
	bh=bKLs1JLpDb52S7R7sWTGcZvpII3rc99gdjJUpbhAaEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fDpUAyHBLE7u7a2lho0dIgg6PH4K0aYWEqMNBREeleeToRFht2tL/l5ksI2Q37+ZfX5sD7n94na+XVD7EtLh7CAqFBcDlqQvJrJ2N5luzezVH1w0PIkI4w5oMwCZ5QNM27tNbunpcxZcLz3+CsK36B+r5l6e0wQe6NooWV6ShGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IKkojfCg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SAcPDqWa; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=itJOJthg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MMZ217R8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EEC4A1F37E;
	Wed, 15 Jan 2025 22:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736981977;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wW0d8F02/tqFPBzOdmeb9J/Rbese3sDUrL6slljcWRI=;
	b=IKkojfCgHT5qH+Fx9QT/HQmEnH6p/g+UtMKwV5JPZwgubUvPAirwUO1mm+Rx1m7MfZkdSB
	w2wRs8QH+pKjEKA3pXtrGlUTUZNAXnxpSpLdqZd51NUhz1YZK0aT6cxoGNvpoI8gMeaevo
	FhF/UJKZ2Ja7IQ2yepUfp4bvkWMn6sE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736981977;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wW0d8F02/tqFPBzOdmeb9J/Rbese3sDUrL6slljcWRI=;
	b=SAcPDqWarapGknMG6EqxsIDJvKKawxyVXj7i4KvigPHXuR3oj9n5s2ePgNa4Xy8cFJf9mg
	nB26YG363RaqkyAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736981976;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wW0d8F02/tqFPBzOdmeb9J/Rbese3sDUrL6slljcWRI=;
	b=itJOJthgR+uKYpzaWnQv5rHaNYdqc8TzpJLelkceU2+569G1dyal29NRNHYloxjFb8m4Ic
	OZbiity/rSaoZOGgu9i8RSEzO4HcdOdv0RdR4NrMkeJ4f5DZBwbzBgE5Q/WvzQUA+1CP4r
	pvnft6+Nf22LYoy6l74SjAkj7B6A7BY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736981976;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wW0d8F02/tqFPBzOdmeb9J/Rbese3sDUrL6slljcWRI=;
	b=MMZ217R8ivlMxfA2H6pQt4iZDTez2867zXycDd5cuySUihe2ueNu0t2eSQh6cKd5OEmLAW
	vIvVMyjzzSQFuFBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BFCC713A6F;
	Wed, 15 Jan 2025 22:59:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ig9LLdg9iGd8CQAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Wed, 15 Jan 2025 22:59:36 +0000
Date: Wed, 15 Jan 2025 23:59:20 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
Cc: Li Wang <liwang@redhat.com>, Cyril Hrubis <chrubis@suse.cz>,
	ltp@lists.linux.it, cgroups@vger.kernel.org
Subject: Re: [LTP] Issue faced in memcg_stat_rss while running mainline
 kernels between 6.7 and 6.8
Message-ID: <20250115225920.GA669149@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <e66fcf77-cf9d-4d14-9e42-1fc4564483bc@oracle.com>
 <PH7PR10MB650583A6483E7A87B43630BDAC302@PH7PR10MB6505.namprd10.prod.outlook.com>
 <20250115125241.GD648257@pevik>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250115125241.GD648257@pevik>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REDIRECTOR_URL(0.00)[urldefense.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto];
	REPLYTO_EQ_FROM(0.00)[]
X-Spam-Score: -3.50
X-Spam-Flag: NO

Hi Harshvardhan,

[ Cc cgroups@vger.kernel.org: FYI problem in recent kernel using cgroup v1 ]

> Kind regards,
> Petr

> > Hi there,
> > I saw your name appear the most in the commit log of memcg_stat_rss.sh so I was wondering if you had any information as to why this is happening. I feel that we have enough reason to believe that this is due to outdated testcases. It’ll be highly appreciated if you could verify this fact.

> > Thanks & Regards,
> > Harshvardhan

> > From: ltp <ltp-bounces+harshvardhan.j.jha=oracle.com@lists.linux.it> on behalf of Harshvardhan Jha via ltp <ltp@lists.linux.it>
> > Date: Thursday, 28 November 2024 at 3:20 PM
> > To: ltp@lists.linux.it <ltp@lists.linux.it>
> > Subject: [LTP] Issue faced in memcg_stat_rss while running mainline kernels between 6.7 and 6.8
> > Hi there,

> > I've been getting test failures on the memcg_stat_rss testcase for
> > mainline 6.12 kernels with 3 tests failing and one being broken.

> > Running tests.......
> > <<<test_start>>>
> > tag=memcg_stat_rss stime=1732003500
> > cmdline="memcg_stat_rss.sh"
> > contacts=""
> > analysis=exit
> > <<<test_output>>>
> > incrementing stop
> > memcg_stat_rss 1 TINFO: Running: memcg_stat_rss.sh
> > memcg_stat_rss 1 TINFO: Tested kernel: Linux harjha-ol9kdevltp
> > 6.12.0-master.20241021.el9.v1.x86_64 #1 SMP PREEMPT_DYNAMIC Mon Oct 21
> > 06:24:22 PDT 2024 x86_64 x86_64 x86_64 GNU/Linux
> > memcg_stat_rss 1 TINFO: Using
> > /tempdir/ltp-Y4AEUmKVIE/LTP_memcg_stat_rss.kEhD0QvvMw as tmpdir (xfs
> > filesystem)
> > memcg_stat_rss 1 TINFO: timeout per run is 0h 5m 0s
> > memcg_stat_rss 1 TINFO: set /sys/fs/cgroup/memory/memory.use_hierarchy
> > to 0 failed
> > memcg_stat_rss 1 TINFO: Setting shmmax
> > memcg_stat_rss 1 TINFO: Running memcg_process --mmap-anon -s 266240
> > memcg_stat_rss 1 TINFO: Warming up pid: 9367
> > memcg_stat_rss 1 TINFO: Process is still here after warm up: 9367
> > memcg_stat_rss 1 TFAIL: rss is 0, 266240 expected
> > memcg_stat_rss 2 TINFO: Running memcg_process --mmap-file -s 4096
> > memcg_stat_rss 2 TINFO: Warming up pid: 9383
> > memcg_stat_rss 2 TINFO: Process is still here after warm up: 9383
> > memcg_stat_rss 2 TPASS: rss is 0 as expected
> > memcg_stat_rss 3 TINFO: Running memcg_process --shm -k 3 -s 4096
> > memcg_stat_rss 3 TINFO: Warming up pid: 9446
> > memcg_stat_rss 3 TINFO: Process is still here after warm up: 9446
> > memcg_stat_rss 3 TPASS: rss is 0 as expected
> > memcg_stat_rss 4 TINFO: Running memcg_process --mmap-anon --mmap-file
> > --shm -s 266240
> > memcg_stat_rss 4 TINFO: Warming up pid: 9462
> > memcg_stat_rss 4 TINFO: Process is still here after warm up: 9462
> > memcg_stat_rss 4 TPASS: rss is 266240 as expected
> > memcg_stat_rss 5 TINFO: Running memcg_process --mmap-lock1 -s 266240
> > memcg_stat_rss 5 TINFO: Warming up pid: 9479
> > memcg_stat_rss 5 TINFO: Process is still here after warm up: 9479
> > memcg_stat_rss 5 TFAIL: rss is 0, 266240 expected
> > memcg_stat_rss 6 TINFO: Running memcg_process --mmap-anon -s 266240
> > memcg_stat_rss 6 TINFO: Warming up pid: 9495
> > memcg_stat_rss 6 TINFO: Process is still here after warm up: 9495
> > memcg_stat_rss 6 TFAIL: rss is 0, 266240 expected
> > memcg_stat_rss 6 TBROK: timed out on memory.usage_in_bytes 4096 266240
> > 266240
> > /opt/ltp-20240930/testcases/bin/tst_test.sh: line 158:  9495
> > Killed                  memcg_process "$@"  (wd:
> > /sys/fs/cgroup/memory/ltp/test-9308/ltp_9308)

> > Summary:
> > passed   3
> > failed   3
> > broken   1
> > skipped  0
> > warnings 0
> > <<<execution_status>>>
> > initiation_status="ok"
> > duration=17 termination_type=exited termination_id=3 corefile=no
> > cutime=13 cstime=58
> > <<<test_end>>>
> > INFO: ltp-pan reported some tests FAIL
> > LTP Version: 20240930

> > I'm not sure whether this error is due to the kernel or the testcase
> > being outdated. I know that since cgroup v2 is the default upstream and
> > cgroup v1 is now a legacy option, this specific testcase is not

Yes, exactly. I have system with cgroup v1, but it's based on 4.12.14.
Even old Debian VM with old 5.10 uses cgroup v2. Therefore I have no change to
debug the problem.

> > particularly higher in the priority list, but just to be sure, I wanted
> > to verify this from your side. Please let me know whether this error is
> > coming due to the testcase being outdated or this in fact is a valid
> > kernel error.

> > I ran a bisect on memcg_stat_rss test upon mainline kernels and saw the
> > bisect range narrow down between 6.7 and 6.8 which further isolated to:
> > https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=7d7ef0a4686abe43cd76a141b340a348f45ecdf2__;!!ACWV5N9M2RV99hQ!Ky0mM2XEGFSiCbcBvjP5FV5IV3kGpDuDEhuFVAGVdD1mXLQPidRcZLqH8k0AFxScjZgYnjCgaCISEgDVlcn4BSoj$<https://urldefense.com/v3/__https:/git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=7d7ef0a4686abe43cd76a141b340a348f45ecdf2__;!!ACWV5N9M2RV99hQ!Ky0mM2XEGFSiCbcBvjP5FV5IV3kGpDuDEhuFVAGVdD1mXLQPidRcZLqH8k0AFxScjZgYnjCgaCISEgDVlcn4BSoj$>

This was a reason to Cc cgroups@vger.kernel.org.

> > This commit was part of a 5 patch series and I wasn't able to revert it
> > on 6.12 without getting a series of conflicts.
> > So, what I did was checkout the SHA before this patch series
> > 4a3bfbd1699e2306731809d50d480634012ed4de and after the patch series
> > 7d7ef0a4686abe43cd76a141b340a348f45ecdf2 and ran this test.

> > The machine had 32GB Ram and 4CPUs.

> > The steps to reproduce this are:

> > #!/bin/bash

> > # After setting default kernel to the desired one
> > if ! grep -q "unified_cgroup_hierarchy=0" /proc/cmdline; then
> >         sudo grubby --update-kernel DEFAULT
> > --args="systemd.unified_cgroup_hierarchy=0"
> >         sudo grubby --update-kernel DEFAULT
> > --args="systemd.legacy_systemd_cgroup_controller"
> >         sudo grubby --update-kernel DEFAULT --args selinux=0
> >         sudo sed -i "/^SELINUX=/s/=.*/=disabled/" /etc/selinux/config
> >         sudo reboot
> > fi

> > cd /opt/ltp
> > rm -rf /tmpdir
> > mkdir /tempdir
> > ./runltp -d /tempdir  -s memcg_stat_rss

Or just:

# PATH="/opt/ltp/testcases/bin:$PATH" memcg_stat_rss.sh

Kind regards,
Petr

> > The results obtained were:

> > Pre bisect culprit (4a3bfbd1699e2306731809d50d480634012ed4de):

> > <<<test_start>>>
> > tag=memcg_stat_rss stime=1731754078
> > cmdline="memcg_stat_rss.sh"
> > contacts=""
> > analysis=exit
> > <<<test_output>>>
> > incrementing stop
> > memcg_stat_rss 1 TINFO: Running: memcg_stat_rss.sh
> > memcg_stat_rss 1 TINFO: Tested kernel: Linux harjha-ol9kdevltp
> > 6.7.0-masterpre.2024111.el9.rc1.x86_64 #1 SMP PREEMPT_DYNAMIC Fri Nov 15
> > 11:56:10 PST 2024 x86_64 x86_64 x86_64 GNU/Linux
> > memcg_stat_rss 1 TINFO: Using
> > /tempdir/ltp-SzE9ADK6MM/LTP_memcg_stat_rss.6op28sMXO2 as tmpdir (xfs
> > filesystem)
> > memcg_stat_rss 1 TINFO: timeout per run is 0h 5m 0s
> > memcg_stat_rss 1 TINFO: set /sys/fs/cgroup/memory/memory.use_hierarchy
> > to 0 failed
> > memcg_stat_rss 1 TINFO: Setting shmmax
> > memcg_stat_rss 1 TINFO: Running memcg_process --mmap-anon -s 266240
> > memcg_stat_rss 1 TINFO: Warming up pid: 34237
> > memcg_stat_rss 1 TINFO: Process is still here after warm up: 34237
> > memcg_stat_rss 1 TPASS: rss is 266240 as expected
> > memcg_stat_rss 1 TBROK: timed out on memory.usage_in_bytes 4096 266240
> > 266240
> > /opt/ltp-20240930/testcases/bin/tst_test.sh: line 158: 34237
> > Killed                  memcg_process "$@"  (wd:
> > /sys/fs/cgroup/memory/ltp/test-34180/ltp_34180)

> > Summary:
> > passed   1
> > failed   0
> > broken   1
> > skipped  0
> > warnings 0
> > <<<execution_status>>>


> > Post bisect culprit(7d7ef0a4686abe43cd76a141b340a348f45ecdf2):

> > <<<test_start>>>
> > tag=memcg_stat_rss stime=1731755339
> > cmdline="memcg_stat_rss.sh"
> > contacts=""
> > analysis=exit
> > <<<test_output>>>
> > incrementing stop
> > memcg_stat_rss 1 TINFO: Running: memcg_stat_rss.sh
> > memcg_stat_rss 1 TINFO: Tested kernel: Linux harjha-ol9kdevltp
> > 6.7.0-masterpost.2024111.el9.rc1.x86_64 #1 SMP PREEMPT_DYNAMIC Fri Nov
> > 15 11:55:41 PST 2024 x86_64 x86_64 x86_64 GNU/Linux
> > memcg_stat_rss 1 TINFO: Using
> > /tempdir/ltp-G6cge4CkrR/LTP_memcg_stat_rss.1zrm6X02CO as tmpdir (xfs
> > filesystem)
> > memcg_stat_rss 1 TINFO: timeout per run is 0h 5m 0s
> > memcg_stat_rss 1 TINFO: set /sys/fs/cgroup/memory/memory.use_hierarchy
> > to 0 failed
> > memcg_stat_rss 1 TINFO: Setting shmmax
> > memcg_stat_rss 1 TINFO: Running memcg_process --mmap-anon -s 266240
> > memcg_stat_rss 1 TINFO: Warming up pid: 9083
> > memcg_stat_rss 1 TINFO: Process is still here after warm up: 9083
> > memcg_stat_rss 1 TFAIL: rss is 0, 266240 expected
> > memcg_stat_rss 1 TBROK: timed out on memory.usage_in_bytes 4096 266240
> > 266240
> > /opt/ltp-20240930/testcases/bin/tst_test.sh: line 158:  9083
> > Killed                  memcg_process "$@"  (wd:
> > /sys/fs/cgroup/memory/ltp/test-9024/ltp_9024)

> > Summary:
> > passed   0
> > failed   1
> > broken   1
> > skipped  0
> > warnings 0
> > <<<execution_status>>>

> > Thanks & Regards,
> > Harshvardhan

