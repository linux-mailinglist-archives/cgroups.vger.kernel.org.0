Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D23EC1A2EB5
	for <lists+cgroups@lfdr.de>; Thu,  9 Apr 2020 07:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725785AbgDIFKD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 9 Apr 2020 01:10:03 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35252 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725271AbgDIFKC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 9 Apr 2020 01:10:02 -0400
Received: by mail-wr1-f65.google.com with SMTP id g3so10401223wrx.2;
        Wed, 08 Apr 2020 22:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=p/HH0I63YdWRi6zlDYRvwzJ5V+QRFikbr1SYHN1Nt0w=;
        b=bxYr4H02EMVAhN2rr3PIeVwESTDIrZeTP52yl2v5asGqpo5KqQ277wQNnIA+SxyNtd
         MQEejIbkAofiSfIxf5nJg8rMNodVMULxPXtSiUdIx9t1H1v4PH6NOF2BZdINeNfhifrs
         rXXSfHkyBMu+OszMxJvBCNuLhRTB4NubYOd5lBIvQOgx8hHChIo4J+OCeLiVVDJ9qRwt
         8aWOYITlmaP6rRJHHo2bCJ7llA2vLaMCMyfodK/Qi+xKzPCRQSmlYsTlT1mT6MyNrrx4
         7HH3uqpmF9vOv1ibeM49KxFYH6aAoZZUJ5GuZ4yLlmWh1vwvi5wg15bVZXFoC0VF1qM3
         nbgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=p/HH0I63YdWRi6zlDYRvwzJ5V+QRFikbr1SYHN1Nt0w=;
        b=N0ebKqOz5tV8I9SIabtntAxpemqd7B7t6Of5aT4zB1Jhoi1fSwdfUKF8mrmAWKdgwe
         EoB0ihTzRcrTsNP4Np0jhP40JmDPzC2CNLwOSmHjklnB+5aYSIZpKW8eL6WF3/aGLC44
         Be4UKgsnaOK5EUL0TbK8vtAn/k5Js6BfzyVnEFm2osYn0FlXHPHOW8cn5DQKGX3xaubv
         mjHE03odlJqKkIG6I94tWWTzpjs5sX0odIoLW6fPTl+gJyR7Cdr6uzYOPh+MU9iea6D5
         W0puj2hrdicP97SutdZktjRYlM0WqhGQmAnwvjy5XlDiLLVVaPozwI9jpiFGG8pghFbB
         uZdw==
X-Gm-Message-State: AGi0PuZlAEb4g9xczWwgD7d33rn+DrjfiAHwlZmHwUG4xKu0dwnBLZMg
        56nbdnvsPD5xTVroFdIJajo=
X-Google-Smtp-Source: APiQypL9EboOn1TZCg8YnzHqNRRhFAOeZw7fvELoPHT8Y/iT/Q2Eot8q5KJp0qOhxd9m8XFSro1NIQ==
X-Received: by 2002:a5d:51c7:: with SMTP id n7mr11790891wrv.11.1586409000111;
        Wed, 08 Apr 2020 22:10:00 -0700 (PDT)
Received: from [192.168.43.177] ([109.126.129.227])
        by smtp.gmail.com with ESMTPSA id 132sm2149268wmc.47.2020.04.08.22.09.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2020 22:09:59 -0700 (PDT)
To:     Ming Lei <ming.lei@redhat.com>, Tejun Heo <tj@kernel.org>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@vger.kernel.org,
        cgroups@vger.kernel.org, newella@fb.com, josef@toxicpanda.com
References: <20200408201450.3959560-1-tj@kernel.org>
 <20200408201450.3959560-3-tj@kernel.org>
 <20200409014406.GA370295@localhost.localdomain>
 <20200409021119.GJ162390@mtj.duckdns.org>
 <20200409023857.GB370295@localhost.localdomain>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 mQINBFmKBOQBEAC76ZFxLAKpDw0bKQ8CEiYJRGn8MHTUhURL02/7n1t0HkKQx2K1fCXClbps
 bdwSHrhOWdW61pmfMbDYbTj6ZvGRvhoLWfGkzujB2wjNcbNTXIoOzJEGISHaPf6E2IQx1ik9
 6uqVkK1OMb7qRvKH0i7HYP4WJzYbEWVyLiAxUj611mC9tgd73oqZ2pLYzGTqF2j6a/obaqha
 +hXuWTvpDQXqcOZJXIW43atprH03G1tQs7VwR21Q1eq6Yvy2ESLdc38EqCszBfQRMmKy+cfp
 W3U9Mb1w0L680pXrONcnlDBCN7/sghGeMHjGKfNANjPc+0hzz3rApPxpoE7HC1uRiwC4et83
 CKnncH1l7zgeBT9Oa3qEiBlaa1ZCBqrA4dY+z5fWJYjMpwI1SNp37RtF8fKXbKQg+JuUjAa9
 Y6oXeyEvDHMyJYMcinl6xCqCBAXPHnHmawkMMgjr3BBRzODmMr+CPVvnYe7BFYfoajzqzq+h
 EyXSl3aBf0IDPTqSUrhbmjj5OEOYgRW5p+mdYtY1cXeK8copmd+fd/eTkghok5li58AojCba
 jRjp7zVOLOjDlpxxiKhuFmpV4yWNh5JJaTbwCRSd04sCcDNlJj+TehTr+o1QiORzc2t+N5iJ
 NbILft19Izdn8U39T5oWiynqa1qCLgbuFtnYx1HlUq/HvAm+kwARAQABtDFQYXZlbCBCZWd1
 bmtvdiAoc2lsZW5jZSkgPGFzbWwuc2lsZW5jZUBnbWFpbC5jb20+iQJOBBMBCAA4FiEE+6Ju
 PTjTbx479o3OWt5b1Glr+6UFAlmKBOQCGwMFCwkIBwIGFQgJCgsCBBYCAwECHgECF4AACgkQ
 Wt5b1Glr+6WxZA//QueaKHzgdnOikJ7NA/Vq8FmhRlwgtP0+E+w93kL+ZGLzS/cUCIjn2f4Q
 Mcutj2Neg0CcYPX3b2nJiKr5Vn0rjJ/suiaOa1h1KzyNTOmxnsqE5fmxOf6C6x+NKE18I5Jy
 xzLQoktbdDVA7JfB1itt6iWSNoOTVcvFyvfe5ggy6FSCcP+m1RlR58XxVLH+qlAvxxOeEr/e
 aQfUzrs7gqdSd9zQGEZo0jtuBiB7k98t9y0oC9Jz0PJdvaj1NZUgtXG9pEtww3LdeXP/TkFl
 HBSxVflzeoFaj4UAuy8+uve7ya/ECNCc8kk0VYaEjoVrzJcYdKP583iRhOLlZA6HEmn/+Gh9
 4orG67HNiJlbFiW3whxGizWsrtFNLsSP1YrEReYk9j1SoUHHzsu+ZtNfKuHIhK0sU07G1OPN
 2rDLlzUWR9Jc22INAkhVHOogOcc5ajMGhgWcBJMLCoi219HlX69LIDu3Y34uIg9QPZIC2jwr
 24W0kxmK6avJr7+n4o8m6sOJvhlumSp5TSNhRiKvAHB1I2JB8Q1yZCIPzx+w1ALxuoWiCdwV
 M/azguU42R17IuBzK0S3hPjXpEi2sK/k4pEPnHVUv9Cu09HCNnd6BRfFGjo8M9kZvw360gC1
 reeMdqGjwQ68o9x0R7NBRrtUOh48TDLXCANAg97wjPoy37dQE7e5Ag0EWYoE5AEQAMWS+aBV
 IJtCjwtfCOV98NamFpDEjBMrCAfLm7wZlmXy5I6o7nzzCxEw06P2rhzp1hIqkaab1kHySU7g
 dkpjmQ7Jjlrf6KdMP87mC/Hx4+zgVCkTQCKkIxNE76Ff3O9uTvkWCspSh9J0qPYyCaVta2D1
 Sq5HZ8WFcap71iVO1f2/FEHKJNz/YTSOS/W7dxJdXl2eoj3gYX2UZNfoaVv8OXKaWslZlgqN
 jSg9wsTv1K73AnQKt4fFhscN9YFxhtgD/SQuOldE5Ws4UlJoaFX/yCoJL3ky2kC0WFngzwRF
 Yo6u/KON/o28yyP+alYRMBrN0Dm60FuVSIFafSqXoJTIjSZ6olbEoT0u17Rag8BxnxryMrgR
 dkccq272MaSS0eOC9K2rtvxzddohRFPcy/8bkX+t2iukTDz75KSTKO+chce62Xxdg62dpkZX
 xK+HeDCZ7gRNZvAbDETr6XI63hPKi891GeZqvqQVYR8e+V2725w+H1iv3THiB1tx4L2bXZDI
 DtMKQ5D2RvCHNdPNcZeldEoJwKoA60yg6tuUquvsLvfCwtrmVI2rL2djYxRfGNmFMrUDN1Xq
 F3xozA91q3iZd9OYi9G+M/OA01husBdcIzj1hu0aL+MGg4Gqk6XwjoSxVd4YT41kTU7Kk+/I
 5/Nf+i88ULt6HanBYcY/+Daeo/XFABEBAAGJAjYEGAEIACAWIQT7om49ONNvHjv2jc5a3lvU
 aWv7pQUCWYoE5AIbDAAKCRBa3lvUaWv7pfmcEACKTRQ28b1y5ztKuLdLr79+T+LwZKHjX++P
 4wKjEOECCcB6KCv3hP+J2GCXDOPZvdg/ZYZafqP68Yy8AZqkfa4qPYHmIdpODtRzZSL48kM8
 LRzV8Rl7J3ItvzdBRxf4T/Zseu5U6ELiQdCUkPGsJcPIJkgPjO2ROG/ZtYa9DvnShNWPlp+R
 uPwPccEQPWO/NP4fJl2zwC6byjljZhW5kxYswGMLBwb5cDUZAisIukyAa8Xshdan6C2RZcNs
 rB3L7vsg/R8UCehxOH0C+NypG2GqjVejNZsc7bgV49EOVltS+GmGyY+moIzxsuLmT93rqyII
 5rSbbcTLe6KBYcs24XEoo49Zm9oDA3jYvNpeYD8rDcnNbuZh9kTgBwFN41JHOPv0W2FEEWqe
 JsCwQdcOQ56rtezdCJUYmRAt3BsfjN3Jn3N6rpodi4Dkdli8HylM5iq4ooeb5VkQ7UZxbCWt
 UVMKkOCdFhutRmYp0mbv2e87IK4erwNHQRkHUkzbsuym8RVpAZbLzLPIYK/J3RTErL6Z99N2
 m3J6pjwSJY/zNwuFPs9zGEnRO4g0BUbwGdbuvDzaq6/3OJLKohr5eLXNU3JkT+3HezydWm3W
 OPhauth7W0db74Qd49HXK0xe/aPrK+Cp+kU1HRactyNtF8jZQbhMCC8vMGukZtWaAwpjWiiH bA==
Subject: Re: [PATCH 2/5] block: add request->io_data_len
Message-ID: <c2b362f5-36f6-116d-ddb5-2445d13d2bac@gmail.com>
Date:   Thu, 9 Apr 2020 08:08:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200409023857.GB370295@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 09/04/2020 05:38, Ming Lei wrote:
> On Wed, Apr 08, 2020 at 10:11:19PM -0400, Tejun Heo wrote:
>> On Thu, Apr 09, 2020 at 09:44:06AM +0800, Ming Lei wrote:
>>> Almost all __blk_mq_end_request() follow blk_update_request(), so the
>>> completed bytes can be passed to __blk_mq_end_request(), then we can
>>> avoid to introduce this field.
>>
>> But on some drivers blk_update_request() may be called multiple times before
>> __blk_mq_end_request() is called and what's needed here is the total number of
>> bytes in the whole request, not just in the final completion.
> 
> OK.
> 
> Another choice might be to record request bytes in rq's payload
> when calling .queue_rq() only for these drivers.
> 
>>
>>> Also there is just 20 callers of __blk_mq_end_request(), looks this kind
>>> of change shouldn't be too big.
>>
>> This would work iff we get rid of partial completions and if we get rid of
>> partial completions, we might as well stop exposing blk_update_request() and
>> __blk_mq_end_request().
> 
> Indeed, we can store the completed bytes in request payload, so looks killing
> partial completion shouldn't be too hard.

struct request already has such field (see @stats_sectors) because of the same
root-cause. I'd prefer killing it as well by following Ming's way, but otherwise
it could be easily adopted.

-- 
Pavel Begunkov
