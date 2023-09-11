Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E9179B0C0
	for <lists+cgroups@lfdr.de>; Tue, 12 Sep 2023 01:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377505AbjIKW0o (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 11 Sep 2023 18:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244421AbjIKU2q (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 11 Sep 2023 16:28:46 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13DDF1A7
        for <cgroups@vger.kernel.org>; Mon, 11 Sep 2023 13:28:41 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9aa0495f9cfso664581566b.1
        for <cgroups@vger.kernel.org>; Mon, 11 Sep 2023 13:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694464119; x=1695068919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u1FlQJT5CLEqBN4p3+flYnqVBEBTd/hK6rhM4bfpcQo=;
        b=keSkKekvqwIC2nMJHzCWV/AeFNM2WTD6VoQF78ASEJw6a0vvmfjndXz1+xjkuOChsS
         AEPn+EtmPW+NSRhWPsfuQfZ42z9h9WtWX5zeJNVeWbDc/c8zrl+qrcDHh5gj7DJ65VeF
         4dTbrH73PijNnjfybihpa0BetXAbRCrKkoOYEp61mSVu0HAxJTOvmEC7S1Czn3SxwPol
         cnAEn2bk5Ilzdz7l19zN5pMUvHJE2YnxpOzA3M40RM39fmvYKpkwBjDROLy2iuVsN7nf
         zM0Ll67J2fpZnmRUbSxOJJivPjTsFFLmC/AzHzLja/qzlo/unauRRG3aWaCKMOiQ0d/5
         ZCOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694464119; x=1695068919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u1FlQJT5CLEqBN4p3+flYnqVBEBTd/hK6rhM4bfpcQo=;
        b=l025g1EVjpsTHPIYlKM5TbRRdkrYbVeaFWj7iO4UVKqac/mozNtTmmSDz7aL+a3+Qm
         iDpK/VA1IAX2/cR86XnRjBx4lYdO21ZoclqdRsB7eikgXXSy8tyKH7r7Gk3XoCClxusr
         VUMDCn8hbVL51EVfFg5XZ9hybaiNx6dqaJBclhWYPx1Faau94K0e7UrL8BgUV1mdQdzh
         wOcN+FSedhDLgxTBYZCohR8XTWO8h1e8JgnO+lj41nivYxD68L7RkPJRYLu5RG+2Y4CZ
         zesyliiQzIfRB0ROFD7NymrZT/aPi1TMieRW7JZc5adXUjuX4XtIvrkHg2hHfhYCHN8M
         ezCw==
X-Gm-Message-State: AOJu0YySS0jcYIqsBJJewhStAhux136SX0sAIG6ZYAUNpU0T/JCVWnGu
        VxIjlueWZJ6kamBxXQCZczFPC4P3gcSjG5vfgs5JnQ==
X-Google-Smtp-Source: AGHT+IEH+9F3gycVz0qnwgTvEbn9nbBIu3p9WJ/4/wKz5bCMECF/tNxMgywpY5TqLFcGd5V515Ju3Zc6mdoqTJJ/WNs=
X-Received: by 2002:a17:907:7244:b0:9a9:f6e7:43fe with SMTP id
 ds4-20020a170907724400b009a9f6e743femr917666ejc.24.1694464119298; Mon, 11 Sep
 2023 13:28:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230831165611.2610118-1-yosryahmed@google.com>
 <20230831165611.2610118-5-yosryahmed@google.com> <ZPX0kCKd4TaVLJY7@dhcp22.suse.cz>
 <CAAPL-u9D2b=iF5Lf_cRnKxUfkiEe0AMDTu6yhrUAzX0b6a6rDg@mail.gmail.com>
 <ZP8SDdjut9VEVpps@dhcp22.suse.cz> <CAAPL-u8NndkB2zHRtF8pVBSTsz854YmUbx62G7bpw6BMJiLaiQ@mail.gmail.com>
 <ZP9rtiRwRv2bQvde@dhcp22.suse.cz> <CAAPL-u9XwMcrqVRu871tGNKa3LKmJSy9pZQ7A98uDbG6ACzMxQ@mail.gmail.com>
 <ZP92xP5rdKdeps7Z@mtj.duckdns.org>
In-Reply-To: <ZP92xP5rdKdeps7Z@mtj.duckdns.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 11 Sep 2023 13:28:00 -0700
Message-ID: <CAJD7tkY-1zC7k-u5ApEhpuFpCbAGpv+CBSXApLipvjf7ScJDdQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] mm: memcg: use non-unified stats flushing for
 userspace reads
To:     Tejun Heo <tj@kernel.org>
Cc:     Wei Xu <weixugc@google.com>, Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Sep 11, 2023 at 1:21=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Mon, Sep 11, 2023 at 01:01:25PM -0700, Wei Xu wrote:
> > Yes, it is the same test (10K contending readers). The kernel change
> > is to remove stats_user_flush_mutex from mem_cgroup_user_flush_stats()
> > so that the concurrent mem_cgroup_user_flush_stats() requests directly
> > contend on cgroup_rstat_lock in cgroup_rstat_flush().
>
> I don't think it'd be a good idea to twist rstat and other kernel interna=
l
> code to accommodate 10k parallel readers. If we want to support that, let=
's
> explicitly support that by implementing better batching in the read path.
> The only guarantee you need is that there has been at least one flush sin=
ce
> the read attempt started, so we can do sth like the following in the read
> path:
>
> 1. Grab a waiter lock. Remember the current timestamp.
>
> 2. Try lock flush mutex. If obtained, drop the waiter lock, flush. Regrab
>    the waiter lock, update the latest flush time to my start time, wake u=
p
>    waiters on the waitqueue (maybe do custom wakeups based on start time?=
).
>
> 3. Release the waiter lock and sleep on the waitqueue.
>
> 4. When woken up, regarb the waiter lock, compare whether the latest flus=
h
>    timestamp is later than my start time, if so, return the latest result=
.
>    If not go back to #2.
>
> Maybe the above isn't the best way to do it but you get the general idea.
> When you have that many concurrent readers, most of them won't need to
> actually flush.

I am testing something vaguely similar to this conceptually, but
doesn't depend on timestamps.

I replaced the mutex with a semaphore, and I added a fallback logic to
unified flushing with a timeout:

  static void mem_cgroup_user_flush_stats(struct mem_cgroup *memcg)
  {
          static DEFINE_SEMAPHORE(user_flush_sem, 1);

          if (atomic_read(&stats_flush_order) <=3D STATS_FLUSH_THRESHOLD)
                  return;

          if (!down_timeout(&user_flush_sem, msecs_to_jiffies(1))) {
                  do_stats_flush(memcg);
                  up(&user_flush_sem);
          } else {
                  do_unified_stats_flush(true);
          }
  }

In do_unified_stats_flush(), I added a wait argument. If set, the
caller will wait for any ongoing flushers before returning (but it
never attempts to flush, so no contention on the underlying rstat
lock). I implemented this using completions. I am running some tests
now, but this should make sure userspace read latency is bounded by
1ms + unified flush time. We basically attempt to flush our subtree
only, if we can't after 1ms, we fallback to unified flushing.

Another benefit I am seeing here is that I tried switching in-kernel
flushers to also use the completion in do_unified_stats_flush().
Basically instead of skipping entirely when someone else is flushing,
they just wait for them to finish (without being serialized or
contending the lock). I see no regressions in my parallel reclaim
benchmark. This should make sure no one ever skips a flush, while
still avoiding too much serialization/contention. I suspect this
should make reclaim heuristics (and other in-kernel flushers) slightly
better.

I will run Wei's benchmark next to see how userspace read latency is affect=
ed.

>
> Thanks.
>
> --
> tejun
