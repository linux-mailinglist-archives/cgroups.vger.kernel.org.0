Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA9AF5845D
	for <lists+cgroups@lfdr.de>; Thu, 27 Jun 2019 16:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbfF0OU3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 27 Jun 2019 10:20:29 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34178 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfF0OU3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 27 Jun 2019 10:20:29 -0400
Received: by mail-qt1-f193.google.com with SMTP id m29so2627678qtu.1;
        Thu, 27 Jun 2019 07:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ibMkJJWkf9wfeR0beVqPsWCh5Yhblc2HN5zfVuXpgPc=;
        b=WNnNyq3R8FEYB2OR4flGfDaN1gAY7zPvl1DH6UtOPQvFdLJb3HAALzv3EDVY/ywtdl
         TpKnrFAROO6vLbl+cRlP7sQ/1Lc580ODR9iQYsWRhQPGRdN8YIyadlaHheXQdXZofolU
         R8XFUCJOYrgrWI9K8MuvklrUsp0h60A6/ga0KIQ8nFq1NYb0GJIUnq8stt4LOn0nAA35
         AQ3BLdfljIXqXQUYnWdrvO0xLRuPg31xcILy/wmDpdItAuKlMBglKb0a/CspeBgyrgLq
         F0l4pO6YScXuy6RtPMh/BgdclgtR8UQWLIqcUDte8+04k4YUjlcbMMIw3z0ZZiZ986yh
         SsnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ibMkJJWkf9wfeR0beVqPsWCh5Yhblc2HN5zfVuXpgPc=;
        b=oHl7sl6VGWOAt51+18jAUdh+oj6HAKrbqX0GVRqejRVq51SJ9pEqp63EWD6OU1Elx3
         AfuZuB90bBVSo81wjzkKqfnxueqTu+17gvc9lLGgOWUq/vWvh6VXRl22WWQa7IsPZ5e/
         w7VXbpUQjtCvSfjk3+LRmykSTHKzJMwAfY93pFcxVZzaeLxkFs5uZ+tiMi89rbo+m92/
         mgaKTNdOrK7bqJBTAlI+D14VzPxEzlKV1kO9Uko/rJYCXHmHO2Lh21HZStH1F8XelF9u
         QY1E4+KQfNPrWO+A1P61gPgiEkkogS5G2lzfRRRMCCCrtBbOf5YI6kWiy5BE4ZGT3umX
         FYvQ==
X-Gm-Message-State: APjAAAVpVU7LunA120tyQLVivGavgMgREtxzGlSnmEnKSwSlPWTPdhAH
        pgybAVjnKsoWBJF2wep6tDQ=
X-Google-Smtp-Source: APXvYqzz3ddo5kehN94RkRnIMw8EXVljFjNANKZxMc7zBPdyQt10KTunLVInpbJ3F2ZQzhNNjIcNhg==
X-Received: by 2002:a0c:d0fc:: with SMTP id b57mr3618236qvh.78.1561645228288;
        Thu, 27 Jun 2019 07:20:28 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::5a51])
        by smtp.gmail.com with ESMTPSA id s134sm1084648qke.51.2019.06.27.07.20.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 07:20:27 -0700 (PDT)
Date:   Thu, 27 Jun 2019 07:20:24 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>
Subject: Re: [PATCH] memcg: Add kmem.slabinfo to v2 for debugging purpose
Message-ID: <20190627142024.GW657710@devbig004.ftw2.facebook.com>
References: <20190626165614.18586-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626165614.18586-1-longman@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello, Waiman.

On Wed, Jun 26, 2019 at 12:56:14PM -0400, Waiman Long wrote:
> With memory cgroup v1, there is a kmem.slabinfo file that can be
> used to view what slabs are allocated to the memory cgroup. There
> is currently no such equivalent in memory cgroup v2. This file can
> be useful for debugging purpose.
> 
> This patch adds an equivalent kmem.slabinfo to v2 with the caveat that
> this file will only show up as ".__DEBUG__.memory.kmem.slabinfo" when the
> "cgroup_debug" parameter is specified in the kernel boot command line.
> This is to avoid cluttering the cgroup v2 interface with files that
> are seldom used by end users.

Can you please take a look at drgn?

  https://github.com/osandov/drgn

Baking in debug interface files always is limited and nasty and drgn
can get you way more flexible debugging / monitoring tool w/o having
to bake in anything into the kernel.  For an example, please take a
look at

  https://lore.kernel.org/bpf/20190614015620.1587672-10-tj@kernel.org/

Thanks.

-- 
tejun
