Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C078AFE7D
	for <lists+cgroups@lfdr.de>; Wed, 11 Sep 2019 16:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbfIKOQf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 11 Sep 2019 10:16:35 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42450 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbfIKOQf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 11 Sep 2019 10:16:35 -0400
Received: by mail-qk1-f193.google.com with SMTP id f13so20923089qkm.9;
        Wed, 11 Sep 2019 07:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bz1mSsuTl+E4vAwMyWtdro8hF2w1GwA4uT5lSquTwhw=;
        b=XP5xHqZ7xOlRXj7HOW4YfjSKWQCcUqBQprIziluIiQnuAsTEkzCybcB7fFfJm27yPR
         GDds5yZIiLTxvxACCXmb197OBE3R2vYBFbX5oUURMbg2GGKciF0uxI85nxPNfswKjMSJ
         W0LYPjiH0p1Z6JT+dM8YBJOmfnn360bKFYmhkBPKstBRfZBnC9kt+Jn6sOkTNkutXH65
         /3JoF0p9BKrGEW2kPfjAkiwAPxJyIapUHhtb2UtDTYd7m2R18FXNoDQX7EiN8uvrfeaY
         m6jQPJfEBMe0sY3RlHXJKhkxcJ2G52HBucA1bVupG1GNaLxpC5whk5FvSs6tN/1JwvTL
         mz5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=bz1mSsuTl+E4vAwMyWtdro8hF2w1GwA4uT5lSquTwhw=;
        b=GZyPR5TpcteGzat3Yb8Xwr9/sMVUbZ4lm60BEK2n5M/nvqKk/NAi4maLuhtntQq0ID
         fnMwQN/yKhIJUMsuJ0+aZPHkT6TFWI0j7bKIhdj4OlIEUqZGa9+MUKViS1z7giXuMdOX
         Dv9AzbSCNwQlvpJNkKDNfnbYvvBPDp+4pxVTNBVTU89D9zyGdhVOHQErPwAIlTPO2WoT
         WNGixiZ/1pg6ERnz8ax85eqi909t5xNYd7Yj1L8X5ezAR+lKn9obLcWb77Dnpr7BiZMy
         gh0qGl8lBncn0aj/T+GIXzrWmBIQTFTpXVpFtx2GC5FV/Iv83mI+mIrT4wel1owgDH63
         ++4w==
X-Gm-Message-State: APjAAAWAxiz8uMkCST/4s8RJW8DiubtyrIVxnJJJFrOt7AqRzuqUKLLy
        /Qj1xNqcvcsqZE700c1lbMQ=
X-Google-Smtp-Source: APXvYqwuwH+uTdCa1/gFy0lDxUqqnquHphTP7vop0X2azQQu3OGdlEUhBiSQpiRxhOW6fyirrD/wFw==
X-Received: by 2002:a37:a3cc:: with SMTP id m195mr34540776qke.443.1568211393921;
        Wed, 11 Sep 2019 07:16:33 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:8b2])
        by smtp.gmail.com with ESMTPSA id u23sm10041210qkm.49.2019.09.11.07.16.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Sep 2019 07:16:33 -0700 (PDT)
Date:   Wed, 11 Sep 2019 07:16:30 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>, clm@fb.com,
        dennisz@fb.com, newella@fb.com, Li Zefan <lizefan@huawei.com>,
        Jens Axboe <axboe@kernel.dk>,
        Josef Bacik <josef@toxicpanda.com>,
        Josef Bacik <jbacik@fb.com>, kernel-team@fb.com,
        Rik van Riel <riel@surriel.com>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/10] blkcg: implement blk-iocost
Message-ID: <20190911141630.GV2263813@devbig004.ftw2.facebook.com>
References: <20190828220600.2527417-1-tj@kernel.org>
 <20190828220600.2527417-9-tj@kernel.org>
 <20190910125513.GA6399@blackbody.suse.cz>
 <20190910160855.GS2263813@devbig004.ftw2.facebook.com>
 <A69EF8D0-8156-46DB-A4DA-C5334764116E@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A69EF8D0-8156-46DB-A4DA-C5334764116E@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Wed, Sep 11, 2019 at 10:18:53AM +0200, Paolo Valente wrote:
> > The two being enabled at the same time doesn't make sense, so we can
> > just switch over to bfq when bfq is selected as the iosched.  I asked
> > what Paolo wanted to do in terms of interface a couple times now but
> > didn't get an answer and he posted a patch which makes the two
> > controllers conflict, so....  Paolo, so it looks like you want to
> > rename all bfq files to drop the bfq prefix, right?
> 
> Yep, mainly because ... this is the solution you voted and you
> yourself proposed [1] :)
> 
> [1] https://patchwork.kernel.org/patch/10988261/

So, that was then.  Since then the interface change has been published
and userspace, at least some of them, already had to adjust.  Now, I
don't have any opinion on the matter and flipping again will cause
inconveniences to some subset of users.  It's your call.

> >  I can implement
> > the switching if so.
> 
> That would be perfect.

Whichever way it gets decided, this is easy enough.  I'll prep a
patch.

Thanks.

-- 
tejun
