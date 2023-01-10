Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8832B664EB3
	for <lists+cgroups@lfdr.de>; Tue, 10 Jan 2023 23:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235341AbjAJWW0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 10 Jan 2023 17:22:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235288AbjAJWVw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 10 Jan 2023 17:21:52 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288E265353;
        Tue, 10 Jan 2023 14:21:16 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9so14710152pll.9;
        Tue, 10 Jan 2023 14:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xQqgkH+X4DgNMo+bVnhMEmwdgUyr4sbsfxgP11tD+Hs=;
        b=aCsRfL5G+B/Q0wKECpcJVdg90d8G+GjqB68k8Pj0uCxNIHy948tppcSeOOjkuwG1ZA
         pCad+QFepRkPEjtp4Gt7b6T7N36io7W4gNa7QYZJXdyxGfQLTxAekKAodf2J9Jtkuauy
         1Vi7e0NID2zLACf5Flq07v2MV0YdyAtFLiSudMFtdETOtd6m8vg7PEwW1uh/CrsmbkVG
         bUu4Z0r+quneEtb5GGEVn8dzzsA7dBw2tz1bVJWQh+EV1pC/M99MZlp0xfkBZpbY1Mcn
         uS4T6ZqMrg6+bjUPzj6jh8/+X8WZ9AARQvjQh1DMKvN6bs19uVNHEsg3vrXV9D9govgQ
         t6Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xQqgkH+X4DgNMo+bVnhMEmwdgUyr4sbsfxgP11tD+Hs=;
        b=vKpPh5Qh8L3b74S6FbMyp2O6rsa6hFGZUfsqjKZjzcLUDiyrf+mdByN7upLYu/bep8
         6T+gKIWYoA8l/Or1OO+6FWcOPjKoC5GKzmwrBtiZuCfPa4CVAlJvWlXqpE8zjkO/FuTH
         frmdpDZhG70xQc/fPFUKcYsNt9Qz74EIWwcOp01YSDqyJSf5zLEQmD01dUVmZIUy5MeK
         prTLP4kfYCxTmDVn+StcgwwAPh9sJuEmaSglb4n33MMpBIbpUoMakTdbR//xpY6QIjSG
         7iBSocouhkfbMlLW8WCyAgztlJ3jRgTZ+xtPf6iwWxqIL0OZnOD+JD3wHsbCvtvMUXgk
         3ejQ==
X-Gm-Message-State: AFqh2kq9vvavq7/KvUAn8d630cDwlk1sEtOBn9D2ZSp8LvgcY4H0CKZ5
        YnNZWYnFmq34lI70MAdJIuM=
X-Google-Smtp-Source: AMrXdXuZrep0qLFUh44eFOtv+3cEbXcUJ0rWXTCy0Xcf6bFZL0DXBgWX1hy6Xms+CdOa4yqfVGs1+Q==
X-Received: by 2002:a17:902:b78c:b0:193:29db:e0b7 with SMTP id e12-20020a170902b78c00b0019329dbe0b7mr10607206pls.54.1673389269230;
        Tue, 10 Jan 2023 14:21:09 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id l4-20020a170902f68400b00192944e3650sm8539497plg.268.2023.01.10.14.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 14:21:08 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 10 Jan 2023 12:21:07 -1000
From:   Tejun Heo <tj@kernel.org>
To:     hanjinke <hanjinke.666@bytedance.com>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com
Subject: Re: [External] Re: [PATCH v4] blk-throtl: Introduce sync and async
 queues for blk-throtl
Message-ID: <Y73k04BhpY/SuwGB@slm.duckdns.org>
References: <20230107130738.75640-1-hanjinke.666@bytedance.com>
 <Y7x7yq5YmcXhVkQf@slm.duckdns.org>
 <b4cf040e-a9d9-8b7a-10cf-80b01d02848f@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b4cf040e-a9d9-8b7a-10cf-80b01d02848f@bytedance.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jan 10, 2023 at 11:59:09PM +0800, hanjinke wrote:
> 
> 
> 在 2023/1/10 上午4:40, Tejun Heo 写道:
> > On Sat, Jan 07, 2023 at 09:07:38PM +0800, Jinke Han wrote:
> > > + * Assumed that there were only bios queued in ASYNC queue and the SYNC
> > > + * queue was empty. The ASYNC bio was selected to dispatch and the
> > > + * disp_sync_cnt was set to 0 after each dispatching. If a ASYNC bio
> > > + * can't be dispatched because of overlimit in current slice, the process
> > > + * of dispatch should give up and the spin lock of the request queue
> > > + * may be released. A new SYNC bio may be queued in the SYNC queue then.
> > > + * When it's time to dispatch this tg, the SYNC bio was selected and pop
> > > + * to dispatch as the disp_sync_cnt is 0 and the SYNC queue is no-empty.
> > > + * If the dispatched bio is smaller than the waiting bio, the bandwidth
> > > + * may be hard to satisfied as the slice may be trimed after each dispatch.
> > 
> > I still can't make a good sense of this scenario. Can you give concrete
> > example scenarios with IOs and why it would matter?
> > 
> > Thanks.
> > 
> 
> Assumed that there are many buffer write bios queued in ASYNC queue and the
> SYNC queue is empty. The buffer write bios are all 1M in size and the bps
> limit is 1M/s. The throtl_slice is 100ms.
> 
> Assumed that the start/end_slice is [jiffies1, jiffies1+100] and
> bytes_disp[w] = 0. The next ASYNC bio can't dispatch because of overlimit
> within this slice. The wait time is 900ms and the slice will be extended to
> [jiffies1, jiffies1 + 1000] in tg_may_dispatch.
> 
> During the waiting of the ASYNC bio, a SYNC 4k bio be queued in SYNC queue.
> After 900ms, it's time to dispatch the ASYNC io, but the SYNC 4k bio be
> selected to be dispatched. Now the slice is [jiffies1, jiffies1+1000] and
> the byte_disp[w] = 4k. The slice may be extended to
> [jiffies1, jiffies1+1100]. In tg_dispatch_one_bio, the slice will be trimed
> to [jiffies1+1000, jiffies1+1100], the byte_disp[w] will set 0.
> 
> After the 4k SYNC bio be dispatched, the WAITING ASYNC bio still cann't
> be dispatched because of overlimit within this slice.
> 
> The same thing may happen DISPACH_SYNC_FACTOR times if alway there is a SYNC
> bio be queued in the SYNC queue when the ASYNC bio is waiting.
> 
> This means that in nearly 5s, we have dispathed 4 4k SYNC bios and a 1m
> ASYNC bio.
> 
> In our test, with 100M/s bps limit setted, the bps only reach to ~80m/s
> when a fio generate buffer write ios and fsync continuous generated by
> dbench in same cgroup.

That makes sense to me. Thanks for the explanation. It'd probably a good
idea to expand the explanation in the comment tho.

Thanks.

-- 
tejun
