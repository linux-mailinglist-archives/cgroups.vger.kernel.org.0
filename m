Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8530C1A6750
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2020 15:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730148AbgDMNwQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Apr 2020 09:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730000AbgDMNwQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Apr 2020 09:52:16 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9CAEC0A3BDC;
        Mon, 13 Apr 2020 06:52:15 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id c63so9449298qke.2;
        Mon, 13 Apr 2020 06:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pEQ2ZN/sQMUNp0cAGyj+0Oo/y3A6wiKh+7dkMJzMwVI=;
        b=MRSZ1qTh0me/yxxie/3CYFIGX8lrDC3ISjXJe6J7lVXk3NNURSYMsAEkOVRdvkUZVL
         K97VBE5C8GBEcLI1j6snQqwxNHlR4+HRv+4c/KG8wrRFOyycSy4N/YUZrTbaWF/itcdj
         cB85PL1NzoFmMsWzbeHhQx6dVVQzIf3ZmbjjAeD+6Zxf9S4eQh8M7DkjB6DbllIxcu9+
         EKj5ePFmNh8aNV2InN7y+YDDIRVaayW85AjvKvBf+4LPxQciv2SkXZe9Pwsh7Sb+gzyp
         dfQBXRF70YH8Zx2h75h9z8upaN74WXugMBbMvCCiTmq4wrRoQAEL6eB/jTiTQivTf8P6
         cxJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=pEQ2ZN/sQMUNp0cAGyj+0Oo/y3A6wiKh+7dkMJzMwVI=;
        b=NnlNV5l2gecQ4fPeqiap813QxvpTfOFGEidjKBRM0IHYzu0JiRis6pOBX7YniBMrLS
         PWdiu2ZG42FT5ILkPSWOwnQE4uXE9VumJ7sMVxBZB3t3sedwkiZ7wDATyqY6v/duduSn
         ImERfNeWW0awC29tRVt6FsMZAUibiWWj4empa+oJSwEFjPZOMDO3IqnnHVbBBB4fCcFb
         PTyfy+yvdJR7DE6l7T906u/gVUsUAPh4zynFR9E17idUP9lj53ZHHKCo5fSinYCvc4eo
         eaNr+fcvwPs8R1GgE99/otzAtG2MAjAKxb1Nis8ZLtANn5VbCMrscRdypaMZfBqMxg9e
         I1pQ==
X-Gm-Message-State: AGi0PuZRS/nHVjVz3z4hrINI0U2WsotxHOO1RX/yaLkL7m7O3/OVIhat
        NGTZDokwL8EP79fnLBFCHeM=
X-Google-Smtp-Source: APiQypLe7MO13U/Rf9ZmvyBPQqLT6zGJOfgTyGiBiUG0HsVQKvD4PRhBAITPJDiJayaHpv91ab4IvA==
X-Received: by 2002:a37:418d:: with SMTP id o135mr16605498qka.349.1586785934916;
        Mon, 13 Apr 2020 06:52:14 -0700 (PDT)
Received: from localhost ([199.96.181.106])
        by smtp.gmail.com with ESMTPSA id c8sm8541264qke.90.2020.04.13.06.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 06:52:14 -0700 (PDT)
Date:   Mon, 13 Apr 2020 09:52:12 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@vger.kernel.org,
        cgroups@vger.kernel.org, newella@fb.com, josef@toxicpanda.com
Subject: Re: [PATCH 2/5] block: add request->io_data_len
Message-ID: <20200413135212.GA60335@mtj.duckdns.org>
References: <20200408201450.3959560-1-tj@kernel.org>
 <20200408201450.3959560-3-tj@kernel.org>
 <b027a718-1c76-6e34-1edb-5435a5605d35@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b027a718-1c76-6e34-1edb-5435a5605d35@acm.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Wed, Apr 08, 2020 at 08:44:17PM -0700, Bart Van Assche wrote:
> On 2020-04-08 13:14, Tejun Heo wrote:
> > diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> > index 32868fbedc9e..bfd34c6a27ef 100644
> > --- a/include/linux/blkdev.h
> > +++ b/include/linux/blkdev.h
> > @@ -142,6 +142,14 @@ struct request {
> >  
> >  	/* the following two fields are internal, NEVER access directly */
> >  	unsigned int __data_len;	/* total data len */
> > +#ifdef CONFIG_BLK_RQ_IO_DATA_LEN
> > +	/*
> > +	 * Total data len at the time of issue. This doesn't get deducted by
> > +	 * blk_update_request() and can be used by completion path to determine
> > +	 * the request size.
> > +	 */
> > +	unsigned int io_data_len;
> > +#endif
> >  	sector_t __sector;		/* sector cursor */
> >  
> >  	struct bio *bio;
> 
> So we have one struct member with the description "total data len" and
> another struct member with the description "total data len at the time
> of issue"? How could one not get confused by these descriptions?

The new one explicitly says it doesn't get deducted by update_request.

> This change makes the comment above __data_len incorrect. Please update
> that comment or move io_data_len in front of that comment.

Sure.

> How does this change interact with the code in drivers/scsi/sd.c that
> manipulates __data_len directly?

It doesn't.

Thanks.

-- 
tejun
