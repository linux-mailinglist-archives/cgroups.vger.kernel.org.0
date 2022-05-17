Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD21529B6B
	for <lists+cgroups@lfdr.de>; Tue, 17 May 2022 09:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240619AbiEQHuW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 17 May 2022 03:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240976AbiEQHuQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 17 May 2022 03:50:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4CC4845042
        for <cgroups@vger.kernel.org>; Tue, 17 May 2022 00:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652773813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fcxa52FaP/LJSTmTsYRMIBzyizNUgowBuXRZOO4RnAA=;
        b=U0d7TY0B82TkkO6tqZHKXZ36AdEwPFn/FvOnUdCkE6VYlsTiQ3wI0vF98MTyoV/PnnnvEs
        zVl9zKxMEZFAW5/e6R4Fm2tunGvPeOkNEDMUGPmOIT++XaxLqd3SihdmEzupBJHwA7PH0O
        7QRjm27eUPY+21QKGhKA4tZssNjB35w=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-433-zzZy4rXjM0e348ewSnTnaA-1; Tue, 17 May 2022 03:50:10 -0400
X-MC-Unique: zzZy4rXjM0e348ewSnTnaA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B12DE3C138A6;
        Tue, 17 May 2022 07:50:09 +0000 (UTC)
Received: from T590 (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 309F9154A380;
        Tue, 17 May 2022 07:50:03 +0000 (UTC)
Date:   Tue, 17 May 2022 15:49:58 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     "yukuai (C)" <yukuai3@huawei.com>
Cc:     Tejun Heo <tj@kernel.org>,
        Zhang Wensheng <zhangwensheng5@huawei.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: Re: [PATCH -next] block: fix io hung of setting throttle limit
 frequently
Message-ID: <YoNTpswO2+tEWbWo@T590>
References: <20220516014429.33723-1-zhangwensheng5@huawei.com>
 <YoKmCOAzwzw3Lz7g@slm.duckdns.org>
 <ca251645-8d52-7a93-6ac2-579d97922a9e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ca251645-8d52-7a93-6ac2-579d97922a9e@huawei.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, May 17, 2022 at 11:12:28AM +0800, yukuai (C) wrote:
> 在 2022/05/17 3:29, Tejun Heo 写道:
> > On Mon, May 16, 2022 at 09:44:29AM +0800, Zhang Wensheng wrote:
> > > diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> > > index 469c483719be..8acb205dfa85 100644
> > > --- a/block/blk-throttle.c
> > > +++ b/block/blk-throttle.c
> > > @@ -1321,12 +1321,14 @@ static void tg_conf_updated(struct throtl_grp *tg, bool global)
> > >   	 * that a group's limit are dropped suddenly and we don't want to
> > >   	 * account recently dispatched IO with new low rate.
> > >   	 */
> > > -	throtl_start_new_slice(tg, READ);
> > > -	throtl_start_new_slice(tg, WRITE);
> > > +	if (!timer_pending(&sq->parent_sq->pending_timer)) {
> > > +		throtl_start_new_slice(tg, READ);
> > > +		throtl_start_new_slice(tg, WRITE);
> > > -	if (tg->flags & THROTL_TG_PENDING) {
> > > -		tg_update_disptime(tg);
> > > -		throtl_schedule_next_dispatch(sq->parent_sq, true);
> > > +		if (tg->flags & THROTL_TG_PENDING) {
> > > +			tg_update_disptime(tg);
> > > +			throtl_schedule_next_dispatch(sq->parent_sq, true);
> > > +		}
> > 
> > Yeah, but this ends up breaking the reason why it's starting the new slices
> > in the first place explained in the commit above, right? I'm not sure what
> > the right solution is but this likely isn't it.
> > 
> Hi, Tejun
> 
> Ming added a condition in tg_with_in_bps_limit():
> -       if (bps_limit == U64_MAX) {
> +       /* no need to throttle if this bio's bytes have been accounted */
> +       if (bps_limit == U64_MAX || bio_flagged(bio, BIO_THROTTLED)) {
> 
> Which will let the first throttled bio to be issued immediately once
> the config if updated.
> 
> Do you think this behaviour is OK? If so, we can do the same for
> tg_with_in_iops_limit.

IMO, you can't do that for iops limit. If BIO_THROTTLED is set for one
bio, all its bytes have been accounted, so no need to throttle this bio
in case of bps limit. iops limit is another story, since io account is
done in request IO which is based on split bio, so the bio(split bio)
still need to be check & throttle in case of iops limit.


Thanks,
Ming

