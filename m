Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7A053B809
	for <lists+cgroups@lfdr.de>; Thu,  2 Jun 2022 13:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233700AbiFBLrS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 2 Jun 2022 07:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233488AbiFBLrP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 2 Jun 2022 07:47:15 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E552250682;
        Thu,  2 Jun 2022 04:47:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C787B21B6F;
        Thu,  2 Jun 2022 11:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654170426; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yU2c05v5u7FyIeRoQARLGBGxinXGPSbObbAhOHtlivk=;
        b=iS7l6vTGZLN97NTh5jQeXGGRyx3mXhgVrXT1uZlWRBfP5ckC33GgQkOvK2jzKixSmNQ/eQ
        TW9e7UxBek/WCPm7Rrd+FAokOBEQg2hgxLXU30+gB/fe5Ka5Lr5WlARJfeaJax9PlVF2Yj
        1Z+PbHJR0Yh1xFV8MIz5ychDM22WHTU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9AA36134F3;
        Thu,  2 Jun 2022 11:47:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SIKzJDqjmGIgCQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Thu, 02 Jun 2022 11:47:06 +0000
Date:   Thu, 2 Jun 2022 13:47:05 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Tadeusz Struk <tadeusz.struk@linaro.org>
Cc:     Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Bui Quang Minh <minhquangbui99@gmail.com>
Subject: Re: [PATCH 2/2] cgroup: Use separate work structs on css release path
Message-ID: <20220602114705.GB21320@blackbody.suse.cz>
References: <Yo/DtjEU/kYr190u@slm.duckdns.org>
 <0babd7df-bdef-9edc-3682-1144bc0c2d2b@linaro.org>
 <Ypf0VnKUMiuRgZqT@slm.duckdns.org>
 <1fb4d8d7-ccc0-b020-715e-38c2dfd94c23@linaro.org>
 <Ypf5jpI7dSmpi4W0@slm.duckdns.org>
 <c3bd8e63-7204-f86d-8efa-254db71185fc@linaro.org>
 <Ypf/MpwzByOrSp6A@slm.duckdns.org>
 <416dc60a-f0e5-7d05-1613-3cd0ca415768@linaro.org>
 <YpgEY/lJbLidLOhc@slm.duckdns.org>
 <0fd1c3fd-fa86-dbed-f3f0-74c91b1efa11@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fd1c3fd-fa86-dbed-f3f0-74c91b1efa11@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jun 01, 2022 at 05:40:51PM -0700, Tadeusz Struk <tadeusz.struk@linaro.org> wrote:
> css_killed_ref_fn() will be called regardless of the value of refcnt (via percpu_ref_kill_and_confirm())
> and it will only enqueue the css_killed_work_fn() to be called later.
> Then css_put()->css_release() will be called before the css_killed_work_fn() will even
> get a chance to run, and it will also *only* enqueue css_release_work_fn() to be called later.
> The problem happens on the second enqueue. So there need to be something in place that
> will make sure that css_killed_work_fn() is done before css_release() can enqueue
> the second job.

IIUC, here you describe the same scenario I broke down at [1].

> Does it sound right?

I added a parameter A there (that is sum of base and percpu references
before kill_css()).
I thought it fails because A == 1 (i.e. killing the base reference),
however, that seems an unlikely situation (because cgroup code uses a
"fuse" reference to pin css for offline_css()).

So the remaining option (at least I find it more likely now) is that
A == 0 (A < 0 would trigger the warning in
percpu_ref_switch_to_atomic_rcu()), aka the ref imbalance. I hope we can
get to the bottom of this with detailed enough tracing of gets/puts.

Splitting the work struct is condradictive to the existing approach with
the "fuse" reference.

(BTW you also wrote On Wed, Jun 01, 2022 at 05:00:44PM -0700, Tadeusz Struk <tadeusz.struk@linaro.org> wrote:
> The fact the css_release() is called (via cgroup_kn_unlock()) just after
> kill_css() causes the css->destroy_work to be enqueued twice on the same WQ
> (cgroup_destroy_wq), just with different function. This results in the
> BUG: corrupted list in insert_work issue.

Where do you see a critical css_release called from cgroup_kn_unlock()?
I always observed the css_release() being called via
percpu_ref_call_confirm_rcu() (in the original and subsequent syzbot
logs.))

Thanks,
Michal

[1] https://lore.kernel.org/r/Yo7KfEOz92kS2z5Y@blackbook/
