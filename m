Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2113C1BD2C
	for <lists+cgroups@lfdr.de>; Mon, 13 May 2019 20:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbfEMSa6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 May 2019 14:30:58 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33668 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfEMSa5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 May 2019 14:30:57 -0400
Received: by mail-qk1-f196.google.com with SMTP id k189so8684020qkc.0
        for <cgroups@vger.kernel.org>; Mon, 13 May 2019 11:30:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=j6peJFl4q7bqwYp959siWYBsnvXU8q7u0HMv/fDdcps=;
        b=LAuSnZmKC56kr/y8DA9WztZ7aG7vzissYOCaC+Svz2aa+tS2MvDVCUVuzCXeo98zSF
         5iBf4WOz4mdkjRBf/oT3krgKJSkbCccfedaeWaOEiXAavepohqdAcasRkNpLF92OmiW1
         6DqF/XCRonq5EFskm7hMMNlCw/uB5Q0mJ9D5OmdNIJ3GMLDnT49RCoaolEIztlTNPn1I
         zlukSL+qQREanbU9PhGf7nqFeU7Y4inFMd6/3QHxfzoyUlzdTyqfLq5Cnp4ztV/c7low
         4nunZO+nkIlhCWeAkTzWi2vYdGC8+NxCPMLz6ekGu+MhlmZB4z1LjWPuzm7l0c+U2tLv
         gSRQ==
X-Gm-Message-State: APjAAAXLl2p24y2J91yW21Vk9ofKCY8DS2c9ceZe6uX2f8zEivCqAQQm
        P8+8e2kbtE1r1xPsemtQk4s=
X-Google-Smtp-Source: APXvYqySj2p3gNrrRMfzGy0ZnXbY7Vu04dcTWAdXGxO5XYpqMnB+WUzkGAPF4aPuYUMMf8ETKWiqoQ==
X-Received: by 2002:a37:ad12:: with SMTP id f18mr22659478qkm.145.1557772256575;
        Mon, 13 May 2019 11:30:56 -0700 (PDT)
Received: from dennisz-mbp ([2620:10d:c091:500::3:b635])
        by smtp.gmail.com with ESMTPSA id w195sm7342975qkb.54.2019.05.13.11.30.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 11:30:55 -0700 (PDT)
Date:   Mon, 13 May 2019 14:30:53 -0400
From:   Dennis Zhou <dennis@kernel.org>
To:     =?utf-8?B?5Lmx55+z?= <zhangliguang@linux.alibaba.com>
Cc:     Tejun Heo <tj@kernel.org>, akpm@linux-foundation.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] fs/writeback: Attach inode's wb to root if needed
Message-ID: <20190513183053.GA73423@dennisz-mbp>
References: <1557389033-39649-1-git-send-email-zhangliguang@linux.alibaba.com>
 <20190509164802.GV374014@devbig004.ftw2.facebook.com>
 <a5bb3773-fef5-ce2b-33b9-18e0d49c33c4@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a5bb3773-fef5-ce2b-33b9-18e0d49c33c4@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Liguang,

On Fri, May 10, 2019 at 09:54:27AM +0800, 乱石 wrote:
> Hi Tejun,
> 
> 在 2019/5/10 0:48, Tejun Heo 写道:
> > Hi Tejun,
> > 
> > On Thu, May 09, 2019 at 04:03:53PM +0800, zhangliguang wrote:
> > > There might have tons of files queued in the writeback, awaiting for
> > > writing back. Unfortunately, the writeback's cgroup has been dead. In
> > > this case, we reassociate the inode with another writeback cgroup, but
> > > we possibly can't because the writeback associated with the dead cgroup
> > > is the only valid one. In this case, the new writeback is allocated,
> > > initialized and associated with the inode. It causes unnecessary high
> > > system load and latency.
> > > 
> > > This fixes the issue by enforce moving the inode to root cgroup when the
> > > previous binding cgroup becomes dead. With it, no more unnecessary
> > > writebacks are created, populated and the system load decreased by about
> > > 6x in the online service we encounted:
> > >      Without the patch: about 30% system load
> > >      With the patch:    about  5% system load
> > Can you please describe the scenario with more details?  I'm having a
> > bit of hard time understanding the amount of cpu cycles being
> > consumed.
> > 
> > Thanks.
> 
> Our search line reported a problem, when containerA was removed,
> containerB and containerC's system load were up to 30%.
> 
> We record the trace with 'perf record cycles:k -g -a', found that wb_init
> was the hotspot function.
> 
> Function call:
> 
> generic_file_direct_write
>    filemap_write_and_wait_range
>       __filemap_fdatawrite_range
>          wbc_attach_fdatawrite_inode
>             inode_attach_wb
>                __inode_attach_wb
>                   wb_get_create
>             wbc_attach_and_unlock_inode
>                if (unlikely(wb_dying(wbc->wb)))
>                   inode_switch_wbs
>                      wb_get_create
>                         ; Search bdi->cgwb_tree from memcg_css->id
>                         ; OR cgwb_create
>                            kmalloc
>                            wb_init       // hot spot
>                            ; Insert to bdi->cgwb_tree, mmecg_css->id as key
> 
> We discussed it through, base on the analysis:  When we running into the
> issue, there is cgroups are being deleted. The inodes (files) that were
> associated with these cgroups have to switch into another newly created
> writeback. We think there are huge amount of inodes in the writeback list
> that time. So we don't think there is anything abnormal. However, one
> thing we possibly can do: enforce these inodes to BDI embedded wirteback
> and we needn't create huge amount of writebacks in that case, to avoid
> the high system load phenomenon. We expect correct wb (best candidate) is
> picked up in next round.
> 
> Thanks,
> Liguang
> 
> > 
> 

If I understand correctly, this is mostlikely caused by a file shared by
cgroup A and cgroup B. This means cgroup B is doing direct io against
the file owned by the dying cgroup A. In this case, the code tries to do
a wb switch. However, it fails to reallocate the wb as it's deleted and
for the original cgrouip A's memcg id.

I think the below may be a better solution. Could you please test it? If
it works, I'll spin a patch with a more involved description.

Thanks,
Dennis

---
diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 36855c1f8daf..fb331ea2a626 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -577,7 +577,7 @@ void wbc_attach_and_unlock_inode(struct writeback_control *wbc,
 	 * A dying wb indicates that the memcg-blkcg mapping has changed
 	 * and a new wb is already serving the memcg.  Switch immediately.
 	 */
-	if (unlikely(wb_dying(wbc->wb)))
+	if (unlikely(wb_dying(wbc->wb)) && !css_is_dying(wbc->wb->memcg_css))
 		inode_switch_wbs(inode, wbc->wb_id);
 }
 
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 72e6d0c55cfa..685563ed9788 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -659,7 +659,7 @@ struct bdi_writeback *wb_get_create(struct backing_dev_info *bdi,
 
 	might_sleep_if(gfpflags_allow_blocking(gfp));
 
-	if (!memcg_css->parent)
+	if (!memcg_css->parent || css_is_dying(memcg_css))
 		return &bdi->wb;
 
 	do {
