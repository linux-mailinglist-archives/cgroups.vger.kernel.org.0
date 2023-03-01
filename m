Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 822A96A6A03
	for <lists+cgroups@lfdr.de>; Wed,  1 Mar 2023 10:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjCAJrk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 Mar 2023 04:47:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjCAJrj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 1 Mar 2023 04:47:39 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568823B218;
        Wed,  1 Mar 2023 01:47:36 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 161071FE12;
        Wed,  1 Mar 2023 09:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1677664055; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FEKtKRNyGCTC82UqNy25qgA9yJtw4/FHNoYTpB8MPsE=;
        b=FWR/kfwDEEyMKMXV8Gye36g2Sj6laW5ZfRc975dH6P4XVUiDv/Fp0FHeRZPoXF9hWKGd9v
        pJWJL3iNNvoRbcGInAFRztMuJVhweZ3mJaMZsXvZaJyvx9SBSBuiqzT7toNdLlZxODUvGB
        ZymHyxMMA3fQPYQmsUavp4kNAYHw4u8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0748F13A63;
        Wed,  1 Mar 2023 09:47:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8wL4ADcf/2PhEwAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 01 Mar 2023 09:47:35 +0000
Date:   Wed, 1 Mar 2023 10:47:34 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     tj@kernel.org, hannes@cmpxchg.org, lizefan.x@bytedance.com,
        peterz@infradead.org, johunt@akamai.com, quic_sudaraja@quicinc.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] cgroup: limit cgroup psi file writes to processes
 with CAP_SYS_RESOURCE
Message-ID: <Y/8fNrNm1B2h/MTb@dhcp22.suse.cz>
References: <20230301014651.1370939-1-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230301014651.1370939-1-surenb@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 28-02-23 17:46:51, Suren Baghdasaryan wrote:
> Currently /proc/pressure/* files can be written only by processes with
> CAP_SYS_RESOURCE capability to prevent any unauthorized user from
> creating psi triggers. However no such limitation is required for
> per-cgroup pressure files. Fix this inconsistency by requiring the same
> capability for writing per-cgroup psi files.
> 
> Fixes: 6db12ee0456d ("psi: allow unprivileged users with CAP_SYS_RESOURCE to write psi files")

Is this really a regression from this commit? 6db12ee0456d is changing
permissions of those files to be world writeable with the
CAP_SYS_RESOURCE requirement. Permissions of cgroup files is not changed
and the default mode is 644 (with root as an owner) so only privileged
processes are allowed without any delegation.

I think you should instead construct this slightly differently. The
ultimate goal is to allow a reasonable delegation after all, no?

So keep your current patch and extend it by removing the min timeout
constrain and justify the change by the necessity of the granularity
tuning as reported by Sudarshan Rajagopala. If this causes any
regression then a revert would also return the min timeout constrain
back and we will have to think about a different approach.

The consistency with the global case is a valid point only partially
because different cgroups might have different owners which is not
usually the case for the global psi interface, right?

Makes sense?
-- 
Michal Hocko
SUSE Labs
