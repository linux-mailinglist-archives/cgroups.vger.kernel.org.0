Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A53748552B
	for <lists+cgroups@lfdr.de>; Wed,  5 Jan 2022 16:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233845AbiAEPAE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 Jan 2022 10:00:04 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:46856 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233813AbiAEPAD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 5 Jan 2022 10:00:03 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7C8A12112A;
        Wed,  5 Jan 2022 15:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641394802; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xOj26D6fm43j15dqVrf0hceSd4J2qRRwl3HK5gQlMgA=;
        b=lvvYVwwLH4vMlbFEB91tnplSrOLp+7YwQpo+uhlNySKemJH50KpRgtNLRV+8JEgAQW3pE0
        +DwGzmzVdOrklBFLEP8GypjyaSR+oNPq9LM1+dHYuPav0bZGbgAUrX/7UDQS2XY05K3cdK
        psrao+/yya4S3ciUOoOT46zGanM5pvM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5805013BE7;
        Wed,  5 Jan 2022 15:00:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 36r6FHKy1WG2YAAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 05 Jan 2022 15:00:02 +0000
Date:   Wed, 5 Jan 2022 15:59:56 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 0/3] mm/memcg: Address PREEMPT_RT problems instead of
 disabling it.
Message-ID: <20220105145956.GB6464@blackbody.suse.cz>
References: <20211222114111.2206248-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211222114111.2206248-1-bigeasy@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Dec 22, 2021 at 12:41:08PM +0100, Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> - lockdep complains were triggered by test_core and test_freezer (both
>   had to run):

This doesn't happen on the patched kernel, correct?

Thanks,
Michal
