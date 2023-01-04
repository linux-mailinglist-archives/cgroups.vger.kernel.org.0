Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12FD965DFA6
	for <lists+cgroups@lfdr.de>; Wed,  4 Jan 2023 23:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240467AbjADWME (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Jan 2023 17:12:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240460AbjADWMD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Jan 2023 17:12:03 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73CF193E7;
        Wed,  4 Jan 2023 14:12:01 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id j8-20020a17090a3e0800b00225fdd5007fso26336316pjc.2;
        Wed, 04 Jan 2023 14:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pKNXM54CWmj3ArGU8axmSVIl3xxiHyUVTW8v6DzGRHA=;
        b=XeyuieaOtOOzRKGFjqn1IrRy3FbUpNBsXgm5p31jD6s62WfLwgMNey9QWnbRAniiTI
         ffWLGD3JyLqTrn3kDeC6Ye79OjQ9b6aI1KxXAOg5mJ3cnwHIaz/XNdSIgPHgKy092C/9
         z/dU/KUeru7A2hoGC84bFrOi1V8+5haTDs+DANlEuNy538SPL7H6GGtJAlBRJoSfsWdV
         Q5EHgRKCpgfbJ0J0+VAKOYZIV9+y4JrXs1V78W16MvAFzweAYYPwAeOe3Zszj6osT6jl
         1qtpRy83+l5cPjnq5rwOlsAona6qhEYXLVJlPd/jFHHWHQMNjHm+7F8OCm59Q09zUY3F
         CrIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pKNXM54CWmj3ArGU8axmSVIl3xxiHyUVTW8v6DzGRHA=;
        b=gFceMz74KirvnQCckeC5eiDGAHrdHOu3NYzfDxYwKhDxI5bqexhI2tgMMaJ9aWOrFZ
         I0EfptFfOHgqINO4j/+t65xrV/EUFPBHh8u41IRjb7AjlM21oDte2Z6gv6o0Bkmc9WV7
         xu7xT2Jy9qwV1oOlOb1CsWZztXC0ghlAaRAIJHmfj8y55BuHsrKFWSMsk7V4RzQqk4Ua
         hib1zbEL+z8241VjdZ0OFTE4VzOE56OXGp0R5qC1yadLcpMVWfGBmmkKQXlCavZZpRQz
         ABBWB2WUPFV94CeWZKihCgIIjmGE6CcsUPh+De+U5KzJqgbl2voJWC8sj0gGIFMWPkEA
         Ning==
X-Gm-Message-State: AFqh2kphq1NrnPVyY/q6YfGbjkU+snuYNO9ogTkZ2YzP3TWDZbbvbCP5
        1j20vuHL0mOE5XxhPOt8kZ0=
X-Google-Smtp-Source: AMrXdXs5iIsV2LNtOVaok+0Pnio9CVJpFiNtbSeHyJGNSVLtmvYrSX0k9cih/OS/l8px84TfOjAu0Q==
X-Received: by 2002:a17:902:f791:b0:192:5ec4:6656 with SMTP id q17-20020a170902f79100b001925ec46656mr48694739pln.3.1672870321040;
        Wed, 04 Jan 2023 14:12:01 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id s24-20020a170902a51800b0018996404dd5sm16780685plq.109.2023.01.04.14.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 14:12:00 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 4 Jan 2023 12:11:58 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Jinke Han <hanjinke.666@bytedance.com>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com
Subject: Re: [PATCH v3] blk-throtl: Introduce sync and async queues for
 blk-throtl
Message-ID: <Y7X5rsnYCAAYRGQd@slm.duckdns.org>
References: <20221226130505.7186-1-hanjinke.666@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221226130505.7186-1-hanjinke.666@bytedance.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Mon, Dec 26, 2022 at 09:05:05PM +0800, Jinke Han wrote:
>  static void throtl_pending_timer_fn(struct timer_list *t);
> +static inline struct bio *throtl_qnode_bio_list_pop(struct throtl_qnode *qn);

Just define it before the first usage? Also, I think it'd be fine to let the
compiler decide whether to inline.

> +#define BLK_THROTL_SYNC(bio) (bio->bi_opf & (REQ_SYNC | REQ_META | REQ_PRIO))

Nitpick but the above is used only in one place. Does it help to define it
as a macro?

> +/**
> + * throtl_qnode_bio_peek - peek a bio for a qn
> + * @qn: the qnode to peek from
> + *
> + * For read qn, just peek bio from the SYNC queue and return.
> + * For write qn, we first ask the next_to_disp for bio and will pop a bio
> + * to fill it if it's NULL. The next_to_disp is used to pin the bio for
> + * next to dispatch. It is necessary. In the dispatching  process, a peeked
> + * bio may can't be dispatched due to lack of budget and has to wait, the
> + * dispatching process may give up and the spin lock of the request queue
> + * will be released. New bio may be queued in as the spin lock were released.
> + * When it's time to dispatch the waiting bio, another bio may be selected to
> + * check the limit and may be dispatched. If the dispatched bio is smaller
> + * than the waiting bio, the bandwidth may be hard to satisfied as we may
> + * trim the slice after each dispatch.
> + * So pinning the next_to_disp to make sure that the waiting bio and the
> + * dispatched one later always the same one in case that the spin lock of
> + * queue was released and re-holded.

Can you please format it better and proof-read it. I can mostly understand
what it's saying but it can be improved quite a bit. Can you elaborate the
starvation scenario further? What about the [a]sync queue split makes this
more likely?

> +/**
> + * throtl_qnode_bio_pop: pop a bio from sync/async queue
> + * @qn: the qnode to pop a bio from
> + *
> + * For write io qn, the target queue to pop was determined by the disp_sync_cnt.
> + * Try to pop bio from target queue, fetch the bio and return it when it is not
> + * empty. If the target queue empty, pop bio from another queue instead.

How about:

        For reads, always pop from the ASYNC queue. For writes, target SYNC
        or ASYNC queue based on disp_sync_cnt. If empty, try the other
        queue.

> +static inline struct bio *throtl_qnode_bio_list_pop(struct throtl_qnode *qn)
> +{
> +	struct bio *bio;
> +	int from = SYNC;
> +
> +	if (qn->disp_sync_cnt == THROTL_SYNC_FACTOR)
> +		from = ASYNC;

?: often is less readable but I wonder whether it'd be more readable here:

        from = qn->disp_sync_cnt == THROTL_SYNC_FACTOR ? ASYNC : SYNC;

> +
> +	bio = bio_list_pop(&qn->bios[from]);
> +	if (!bio) {
> +		from = 1 - from;
> +		bio = bio_list_pop(&qn->bios[from]);
> +	}
> +
> +	if ((qn->disp_sync_cnt < THROTL_SYNC_FACTOR) &&
> +		(from == SYNC))

Why the line break? Also, this may be more personal preference but I'm not
sure the parentheses are helping much here.

> +		qn->disp_sync_cnt++;
> +	else
> +		qn->disp_sync_cnt = 0;
> +
> +	return bio;
> +}

Thanks.

-- 
tejun
