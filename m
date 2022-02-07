Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 764A44AC93D
	for <lists+cgroups@lfdr.de>; Mon,  7 Feb 2022 20:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233813AbiBGTNN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 7 Feb 2022 14:13:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240081AbiBGTJv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 7 Feb 2022 14:09:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1E1C0401DA;
        Mon,  7 Feb 2022 11:09:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D514EB80EF6;
        Mon,  7 Feb 2022 19:09:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F935C340EE;
        Mon,  7 Feb 2022 19:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1644260988;
        bh=1RclloxgFVd2RY/SeAe+aZcV9sRA2fEBnErBCQ5PRjk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FFY2E0gZcn+hlSYQnpefUNBA1l5rE11wEoXKl40YqV1L1HpuqhxmQ+kJNZu2t373W
         AjoDjYCQxy2ZubNzmVoAB4s6o/jE/wIg65oRrZ4Gg/7IbWTaQBO1slEgGnuCXBGRd7
         L+OKUzs+E87cP4vkY5QndLicBOgQ4Yc4qujZ4vsU=
Date:   Mon, 7 Feb 2022 11:09:47 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Waiman Long <longman@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Ira Weiny <ira.weiny@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <guro@fb.com>, Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH v4 3/4] mm/page_owner: Print memcg information
Message-Id: <20220207110947.f07b58898d91c02090f9aacf@linux-foundation.org>
In-Reply-To: <YgFUxFI5bMbc42j4@dhcp22.suse.cz>
References: <20220131192308.608837-5-longman@redhat.com>
        <20220202203036.744010-4-longman@redhat.com>
        <YfvOp5VXrxy9IW1w@dhcp22.suse.cz>
        <3f042edb-3769-afea-17a7-899578cd5c69@redhat.com>
        <YgFUxFI5bMbc42j4@dhcp22.suse.cz>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, 7 Feb 2022 18:20:04 +0100 Michal Hocko <mhocko@suse.com> wrote:

> On Thu 03-02-22 14:03:58, Waiman Long wrote:
> > On 2/3/22 07:46, Michal Hocko wrote:
> > > On Wed 02-02-22 15:30:35, Waiman Long wrote:
> > > [...]
> ...
> > > > +	online = (memcg->css.flags & CSS_ONLINE);
> > > > +	cgroup_name(memcg->css.cgroup, name, sizeof(name));
> > > Is there any specific reason to use another buffer allocated on the
> > > stack? Also 80B seems too short to cover NAME_MAX.
> > > 
> > > Nothing else jumped at me.
> > 
> > I suppose we can print directly into kbuf with cgroup_name(), but using a
> > separate buffer is easier to read and understand. 79 characters should be
> > enough for most cgroup names. Some auto-generated names with some kind of
> > embedded uuids may be longer than that, but the random sequence of hex
> > digits that may be missing do not convey much information for identification
> > purpose. We can always increase the buffer length later if it turns out to
> > be an issue.
> 
> Cutting a name short sounds like a source of confusion and there doesn't
> seem to be any good reason for that.

Yes.  If we give them 79 characters, someone will go and want 94.  If
we can prevent this once and for ever, let's please do so.

