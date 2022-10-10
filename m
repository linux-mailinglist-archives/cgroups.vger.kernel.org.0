Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D735F9AE2
	for <lists+cgroups@lfdr.de>; Mon, 10 Oct 2022 10:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbiJJIW4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 10 Oct 2022 04:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbiJJIWi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 10 Oct 2022 04:22:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8474D5A81F;
        Mon, 10 Oct 2022 01:22:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 293E721901;
        Mon, 10 Oct 2022 08:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1665390156; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HJPGZK8y3k1EdlBwZWhtE19zM4qXrS86KACobAplA5c=;
        b=j0gqi2tCSAYg+2GXk/+EeCES7X6tg7S5oB0vr83zi2nQduiHZw+W2Hu5aF1zlINr5XVka4
        pbLxvD7u3GAstRFlR5w2//DEvpjXzNRxEPes7o0VwDIoyv9Why785oh7sj7wVrfeO43mtL
        315BMCvGL8cnHWCnlROYGj6JZaJcGow=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F2C0413ACA;
        Mon, 10 Oct 2022 08:22:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id l2DkOEvWQ2NkbAAAMHmgww
        (envelope-from <mkoutny@suse.com>); Mon, 10 Oct 2022 08:22:35 +0000
Date:   Mon, 10 Oct 2022 10:22:34 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v2] cgroup: Reorganize css_set_lock and kernfs path
 processing
Message-ID: <Y0PWSlNmWT+1mkvB@blackbook>
References: <20220905170944.23071-1-mkoutny@suse.com>
 <Yxd/sUQ/NB3NlC6f@slm.duckdns.org>
 <YzQw/EvH9Sb58Au2@blackbook>
 <Yz21I9UpXafWMU0K@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yz21I9UpXafWMU0K@slm.duckdns.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Oct 05, 2022 at 06:47:31AM -1000, Tejun Heo <tj@kernel.org> wrote:
> Hmm... isn't current's root cgrp guaranteed to be alive?

True on the default hierarchy. v1 hierarchies (singular ones with root
cgroup only) can be unmounted.

> How would cgroup_get_live() fail?

kill_sb is not synchronized via css_set_lock.

> Also, shouldn't cgroup_get() enough for path walking?

If ref count dropped to zero, release callback (css_release_work_fn)
would be queued, cgroup_get would increase the refcount but it won't
cancel this.

Note these were concerns with the first version of the patch that also touched
cgroup_show_path() (that processes v1 hierarchies too). With the
reduction I avoided this.

Strictly speaking, even css_set_lock is unnecessary around
current_cgns_cgroup_from_root() when called with cgrp_dfl_root as the
cset->cgrp_links is not traversed at all.

> If you really wanna do it this way, can you please add a detailed comment
> here why this is safe? But I'd prefer just doing a strightforward ref
> inc/dec around it.

I see the the extraction under css_set_lock without inc/dec turns out
confusing. Let me expand the idea above and avoid css_set_lock
completely (another message).

Michal
