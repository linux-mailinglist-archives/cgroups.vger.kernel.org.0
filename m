Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 314307C46C9
	for <lists+cgroups@lfdr.de>; Wed, 11 Oct 2023 02:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344336AbjJKAgx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 10 Oct 2023 20:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344316AbjJKAgw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 10 Oct 2023 20:36:52 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8ACB99
        for <cgroups@vger.kernel.org>; Tue, 10 Oct 2023 17:36:49 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d84acda47aeso8396794276.3
        for <cgroups@vger.kernel.org>; Tue, 10 Oct 2023 17:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696984609; x=1697589409; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZhPeCxvioG75cIV47i0mJdVPOUMQNjsIUo5SWKluyZ8=;
        b=htvGbVmCNoVXyQXFJi0lqAvfyeeCe44SwqFB02tic1KUk+8Vm0/RvL/3hTBRtuJX0J
         F5G7CuqTHVuJhFB4KQEf9KAdQEaDu3ztl9PCqbRn1QmmGmnmuhoEOSBJUeoucsgMlqtW
         AbIHcJiv/Axyo3KNLTgXGO9muA2MbCsl/VZtnV5dGmguKFWzVrwamoctUp/EDH98MHs2
         qPzVWiYlomNOPyoqDtfgfiiUBokIKDB1KC7usfIQK4Z5F19Rnslc5OZnK3KCFZzggmI2
         KbGVOSjL9Z0CXd5savtRW6Nyr3eOUsGytUxJzPvvhrffghQVIaxRlWBOBYbJoVHxkBg+
         k6Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696984609; x=1697589409;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZhPeCxvioG75cIV47i0mJdVPOUMQNjsIUo5SWKluyZ8=;
        b=rpUMLyhFyU+U/1aGjolG51ZGK0nNVD395dNLwVQEMbYuaBfpptgUhEqlk71sAesKDy
         eUUFLPxUrh8ztOkJZgoRzqPqc40bdAWM6LrEbHkVxGoRCcu8d2aMyCQQsCHjQAicj+i+
         EkbtkBHMAwpgAxdBSvEaZOzXA6e/Z8uZFwkBmLoZxjq1AeV2ay608ePM75V2VAaJlyJW
         pd/+2J8b9Dj+44wz8DRppkf8UOQ6/22b6xyzdpw4mUxNCR8qlCLzA107g3v+cOcbHmZP
         eVi8QqLxeo0dd+SOxpTm0GQieVs60CXh4pSg2Tjs4v+0mjh8PPgSXQkbTeLvmgH1RGZd
         pRcA==
X-Gm-Message-State: AOJu0YyBtbMWEnaAtVExH0Rex39lUcJ9ewTPT0rAxciKHQLHoIKr62BL
        qahP5T4OLcK8QYCiU5xeYCncb+hkzoVVXQ==
X-Google-Smtp-Source: AGHT+IGHnwzxg50++ozxwLsaeRm/ESc9Pd3ZVKaSIuIqMREmxKrAvVLKLElsvPC1UxWyaPjg4RWGiHT2xG2jVA==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a25:5f01:0:b0:d77:f7c3:37db with SMTP id
 t1-20020a255f01000000b00d77f7c337dbmr356863ybb.8.1696984609065; Tue, 10 Oct
 2023 17:36:49 -0700 (PDT)
Date:   Wed, 11 Oct 2023 00:36:46 +0000
In-Reply-To: <CAJD7tkZSanKOynQmVcDi_y4+J2yh+n7=oP97SDm2hq1kfY=ohw@mail.gmail.com>
Mime-Version: 1.0
References: <20231010032117.1577496-1-yosryahmed@google.com>
 <20231010032117.1577496-4-yosryahmed@google.com> <CALvZod5nQrf=Y24u_hzGOTXYBfnt-+bo+cYbRMRpmauTMXJn3Q@mail.gmail.com>
 <CAJD7tka=kjd42oFpTm8FzMpNedxpJCUj-Wn6L=zrFODC610A-A@mail.gmail.com> <CAJD7tkZSanKOynQmVcDi_y4+J2yh+n7=oP97SDm2hq1kfY=ohw@mail.gmail.com>
Message-ID: <20231011003646.dt5rlqmnq6ybrlnd@google.com>
Subject: Re: [PATCH v2 3/5] mm: memcg: make stats flushing threshold per-memcg
From:   Shakeel Butt <shakeelb@google.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        "Michal =?utf-8?Q?Koutn=C3=BD?=" <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>, kernel-team@cloudflare.com,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Oct 10, 2023 at 03:21:47PM -0700, Yosry Ahmed wrote:
[...]
> 
> I tried this on a machine with 72 cpus (also ixion), running both
> netserver and netperf in /sys/fs/cgroup/a/b/c/d as follows:
> # echo "+memory" > /sys/fs/cgroup/cgroup.subtree_control
> # mkdir /sys/fs/cgroup/a
> # echo "+memory" > /sys/fs/cgroup/a/cgroup.subtree_control
> # mkdir /sys/fs/cgroup/a/b
> # echo "+memory" > /sys/fs/cgroup/a/b/cgroup.subtree_control
> # mkdir /sys/fs/cgroup/a/b/c
> # echo "+memory" > /sys/fs/cgroup/a/b/c/cgroup.subtree_control
> # mkdir /sys/fs/cgroup/a/b/c/d
> # echo 0 > /sys/fs/cgroup/a/b/c/d/cgroup.procs
> # ./netserver -6
> 
> # echo 0 > /sys/fs/cgroup/a/b/c/d/cgroup.procs
> # for i in $(seq 10); do ./netperf -6 -H ::1 -l 60 -t TCP_SENDFILE --
> -m 10K; done

You are missing '&' at the end. Use something like below:

#!/bin/bash
for i in {1..22}
do
   /data/tmp/netperf -6 -H ::1 -l 60 -t TCP_SENDFILE -- -m 10K &
done
wait

