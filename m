Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E161370EC80
	for <lists+cgroups@lfdr.de>; Wed, 24 May 2023 06:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjEXEWy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 24 May 2023 00:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbjEXEWx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 24 May 2023 00:22:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4374E6
        for <cgroups@vger.kernel.org>; Tue, 23 May 2023 21:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684902131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8RThbuZCrca9ja7PWjTCEifSQrfusG35C3xzRTql4Rg=;
        b=cYNb0sAiu/W6R/ezsJOfoKzDhh0X6MACnGi3jNBPawLquYmEKzuQglKuJLI1ipnDP//yu2
        vQ6jZoIftNOKDum5JTEkAvlHuYxy+YHW3jg+L1SSEQUGTx4+yQ5vum5yp1Z6m4ByYdqlaa
        e3AosYOaBk21sqAe9VIJITh787uhq7g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-659-F5la8j4wM1GiyPo0V-Mo0A-1; Wed, 24 May 2023 00:22:07 -0400
X-MC-Unique: F5la8j4wM1GiyPo0V-Mo0A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E5A52811E85;
        Wed, 24 May 2023 04:22:06 +0000 (UTC)
Received: from ovpn-8-17.pek2.redhat.com (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8B0532166B25;
        Wed, 24 May 2023 04:21:59 +0000 (UTC)
Date:   Wed, 24 May 2023 12:21:53 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>, Linux-MM <linux-mm@kvack.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        mkoutny@suse.com, ming.lei@redhat.com
Subject: Re: [PATCH] blk-cgroup: Flush stats before releasing blkcg_gq
Message-ID: <ZG2Q4f2eL1vCTWEd@ovpn-8-17.pek2.redhat.com>
References: <20230524011935.719659-1-ming.lei@redhat.com>
 <CAJD7tkZkbro4H-QC=RJx_dfCdGQ5c=4NJhbFrcEmQSidaaMOmg@mail.gmail.com>
 <ZG14VnHl20lt9jLc@ovpn-8-17.pek2.redhat.com>
 <cfef97ec-bb77-4ccb-a0b2-8f1eb66afeb6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cfef97ec-bb77-4ccb-a0b2-8f1eb66afeb6@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, May 24, 2023 at 12:10:55AM -0400, Waiman Long wrote:
> 
> On 5/23/23 22:37, Ming Lei wrote:
> > Hi Yosry,
> > 
> > On Tue, May 23, 2023 at 07:06:38PM -0700, Yosry Ahmed wrote:
> > > Hi Ming,
> > > 
> > > On Tue, May 23, 2023 at 6:21 PM Ming Lei <ming.lei@redhat.com> wrote:
> > > > As noted by Michal, the blkg_iostat_set's in the lockless list
> > > > hold reference to blkg's to protect against their removal. Those
> > > > blkg's hold reference to blkcg. When a cgroup is being destroyed,
> > > > cgroup_rstat_flush() is only called at css_release_work_fn() which
> > > > is called when the blkcg reference count reaches 0. This circular
> > > > dependency will prevent blkcg and some blkgs from being freed after
> > > > they are made offline.
> > > I am not at all familiar with blkcg, but does calling
> > > cgroup_rstat_flush() in offline_css() fix the problem?
> > Except for offline, this list needs to be flushed after the associated disk
> > is deleted.
> > 
> > > or can items be
> > > added to the lockless list(s) after the blkcg is offlined?
> > Yeah.
> > 
> > percpu_ref_*get(&blkg->refcnt) still can succeed after the percpu refcnt
> > is killed in blkg_destroy() which is called from both offline css and
> > removing disk.
> 
> As suggested by Tejun, we can use percpu_ref_tryget(&blkg->refcnt) to make
> sure that we can only take a reference when the blkg is online. I think it
> is a bit safer to take a percpu refcnt to avoid use after free. My other

blkg_release() does guarantee that no new stat associated with this
blkg can be added any more, so what is the use-after-free?

> concern about your patch is that the per cpu list iterations will be done
> multiple times when a blkcg is destroyed if many blkgs are attached to the

Yeah, but is it one big deal? The percpu list should be flushed just in one
of blkg's release handler.

> blkcg. I still prefer to do it once in blkcg_destroy_blkgs(). I am going to

Problem is that new stat still may be added to this list after
percpu_ref_kill() returns.

To be honest, I really hate to grab/put blkg refcnt for adding/consuming
state, and this way is too fragile.

Thanks,
Ming

