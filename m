Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3FD1A2E12
	for <lists+cgroups@lfdr.de>; Thu,  9 Apr 2020 05:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgDIDoU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 8 Apr 2020 23:44:20 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46672 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgDIDoU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 8 Apr 2020 23:44:20 -0400
Received: by mail-pl1-f195.google.com with SMTP id x2so727786plv.13;
        Wed, 08 Apr 2020 20:44:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=OXkeFG20skcc71TAGOC9c852SkMQODtXDz/IIRq3REQ=;
        b=sG62G8MllzdO1LOIBfqJtr2czs0jMkVTAf7ofzaJV4s7nM9CHDXFDp9wl5SU3VJu8y
         loWkQFmtaPetzzZYbQlYXXdAkhTqsz0dyLFxTpjEkDAvOMyhHubh/GNL+NCcXCRVgMEk
         Y50WUFxaM6dtGLXlBoEY6MYDpNylglAsw5YRO3y0Z6CFlzOL0tgY9awo7JO/YIfjs8nQ
         Nn+478UR689FzWfRteofpyZTjQcwxXEEG47hL+zlmpmOM7fzlm2YFHIX1Ems4RRsOnce
         pGoqELUFNLAkzuMu2vMX5XOAyitd86QtoHYkfWmh7XxnjtwFQytvhDOWV0NrBfzv59Cv
         C1Lw==
X-Gm-Message-State: AGi0PuYs/S+p1Zy1ObdmoyzxddF50rBWJMpJ5aK3NRcQYjYKgWp2Qewy
        U0+FZW1FKzIsaDdwT3ynG8I=
X-Google-Smtp-Source: APiQypLDbgLY1AQ+vojJPnsjjGcyD/huzrXAih4H9fuA8yIo1VgDQM/6g/UO45JiZUOO8WT0t3IM6Q==
X-Received: by 2002:a17:90a:254f:: with SMTP id j73mr8604897pje.11.1586403859224;
        Wed, 08 Apr 2020 20:44:19 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:bd77:8b6f:2298:c636? ([2601:647:4000:d7:bd77:8b6f:2298:c636])
        by smtp.gmail.com with ESMTPSA id n100sm862024pjc.38.2020.04.08.20.44.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2020 20:44:18 -0700 (PDT)
Subject: Re: [PATCH 2/5] block: add request->io_data_len
To:     Tejun Heo <tj@kernel.org>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@vger.kernel.org, cgroups@vger.kernel.org,
        newella@fb.com, josef@toxicpanda.com
References: <20200408201450.3959560-1-tj@kernel.org>
 <20200408201450.3959560-3-tj@kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
Autocrypt: addr=bvanassche@acm.org; prefer-encrypt=mutual; keydata=
 mQENBFSOu4oBCADcRWxVUvkkvRmmwTwIjIJvZOu6wNm+dz5AF4z0FHW2KNZL3oheO3P8UZWr
 LQOrCfRcK8e/sIs2Y2D3Lg/SL7qqbMehGEYcJptu6mKkywBfoYbtBkVoJ/jQsi2H0vBiiCOy
 fmxMHIPcYxaJdXxrOG2UO4B60Y/BzE6OrPDT44w4cZA9DH5xialliWU447Bts8TJNa3lZKS1
 AvW1ZklbvJfAJJAwzDih35LxU2fcWbmhPa7EO2DCv/LM1B10GBB/oQB5kvlq4aA2PSIWkqz4
 3SI5kCPSsygD6wKnbRsvNn2mIACva6VHdm62A7xel5dJRfpQjXj2snd1F/YNoNc66UUTABEB
 AAG0JEJhcnQgVmFuIEFzc2NoZSA8YnZhbmFzc2NoZUBhY20ub3JnPokBOQQTAQIAIwUCVI67
 igIbAwcLCQgHAwIBBhUIAgkKCwQWAgMBAh4BAheAAAoJEHFcPTXFzhAJ8QkH/1AdXblKL65M
 Y1Zk1bYKnkAb4a98LxCPm/pJBilvci6boefwlBDZ2NZuuYWYgyrehMB5H+q+Kq4P0IBbTqTa
 jTPAANn62A6jwJ0FnCn6YaM9TZQjM1F7LoDX3v+oAkaoXuq0dQ4hnxQNu792bi6QyVdZUvKc
 macVFVgfK9n04mL7RzjO3f+X4midKt/s+G+IPr4DGlrq+WH27eDbpUR3aYRk8EgbgGKvQFdD
 CEBFJi+5ZKOArmJVBSk21RHDpqyz6Vit3rjep7c1SN8s7NhVi9cjkKmMDM7KYhXkWc10lKx2
 RTkFI30rkDm4U+JpdAd2+tP3tjGf9AyGGinpzE2XY1K5AQ0EVI67igEIAKiSyd0nECrgz+H5
 PcFDGYQpGDMTl8MOPCKw/F3diXPuj2eql4xSbAdbUCJzk2ETif5s3twT2ER8cUTEVOaCEUY3
 eOiaFgQ+nGLx4BXqqGewikPJCe+UBjFnH1m2/IFn4T9jPZkV8xlkKmDUqMK5EV9n3eQLkn5g
 lco+FepTtmbkSCCjd91EfThVbNYpVQ5ZjdBCXN66CKyJDMJ85HVr5rmXG/nqriTh6cv1l1Js
 T7AFvvPjUPknS6d+BETMhTkbGzoyS+sywEsQAgA+BMCxBH4LvUmHYhpS+W6CiZ3ZMxjO8Hgc
 ++w1mLeRUvda3i4/U8wDT3SWuHcB3DWlcppECLkAEQEAAYkBHwQYAQIACQUCVI67igIbDAAK
 CRBxXD01xc4QCZ4dB/0QrnEasxjM0PGeXK5hcZMT9Eo998alUfn5XU0RQDYdwp6/kMEXMdmT
 oH0F0xB3SQ8WVSXA9rrc4EBvZruWQ+5/zjVrhhfUAx12CzL4oQ9Ro2k45daYaonKTANYG22y
 //x8dLe2Fv1By4SKGhmzwH87uXxbTJAUxiWIi1np0z3/RDnoVyfmfbbL1DY7zf2hYXLLzsJR
 mSsED/1nlJ9Oq5fALdNEPgDyPUerqHxcmIub+pF0AzJoYHK5punqpqfGmqPbjxrJLPJfHVKy
 goMj5DlBMoYqEgpbwdUYkH6QdizJJCur4icy8GUNbisFYABeoJ91pnD4IGei3MTdvINSZI5e
Message-ID: <b027a718-1c76-6e34-1edb-5435a5605d35@acm.org>
Date:   Wed, 8 Apr 2020 20:44:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200408201450.3959560-3-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2020-04-08 13:14, Tejun Heo wrote:
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 32868fbedc9e..bfd34c6a27ef 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -142,6 +142,14 @@ struct request {
>  
>  	/* the following two fields are internal, NEVER access directly */
>  	unsigned int __data_len;	/* total data len */
> +#ifdef CONFIG_BLK_RQ_IO_DATA_LEN
> +	/*
> +	 * Total data len at the time of issue. This doesn't get deducted by
> +	 * blk_update_request() and can be used by completion path to determine
> +	 * the request size.
> +	 */
> +	unsigned int io_data_len;
> +#endif
>  	sector_t __sector;		/* sector cursor */
>  
>  	struct bio *bio;

So we have one struct member with the description "total data len" and
another struct member with the description "total data len at the time
of issue"? How could one not get confused by these descriptions?

This change makes the comment above __data_len incorrect. Please update
that comment or move io_data_len in front of that comment.

How does this change interact with the code in drivers/scsi/sd.c that
manipulates __data_len directly?

Thanks,

Bart.


