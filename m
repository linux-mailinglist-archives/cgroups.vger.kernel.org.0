Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB86A49CD47
	for <lists+cgroups@lfdr.de>; Wed, 26 Jan 2022 16:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235788AbiAZPE6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Jan 2022 10:04:58 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:38694 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235639AbiAZPE6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 Jan 2022 10:04:58 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 96502212BC;
        Wed, 26 Jan 2022 15:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643209497; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wve7EDfUiotTqBF9gXhZsF9PhXL/T2VSywPA7zpoBhs=;
        b=AcpcmlAldD0ooUGgzhIY1qoKd9Tu9uvjxPlJzz9L8Nx2kKK47YY/ymKLq52bEQyPFdjGNl
        mWc+kU/NxSqStSWxnoCjLG8mGej1nUWqaD9Kv6QtIr3qquzZBjAe0OhIggJq6NVcOeRff2
        T5lyZygK5811yuxA5nyGyyCx/FIDk54=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 43E2413C53;
        Wed, 26 Jan 2022 15:04:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Q206Dxlj8WGHEwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 26 Jan 2022 15:04:57 +0000
Date:   Wed, 26 Jan 2022 16:04:55 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Michal Hocko <mhocko@suse.com>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 1/4] mm/memcg: Disable threshold event handlers on
 PREEMPT_RT
Message-ID: <20220126150455.GC2516@blackbody.suse.cz>
References: <20220125164337.2071854-1-bigeasy@linutronix.de>
 <20220125164337.2071854-2-bigeasy@linutronix.de>
 <YfFddqkAhd1YKqX9@dhcp22.suse.cz>
 <YfFegDwQSm9v2Qcu@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YfFegDwQSm9v2Qcu@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jan 26, 2022 at 03:45:20PM +0100, Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> If that is not good, let me think of something else…

I like ifdefing just the static branch enablement. *wink*

Michal
