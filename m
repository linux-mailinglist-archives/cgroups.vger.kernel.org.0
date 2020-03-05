Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F620179D7A
	for <lists+cgroups@lfdr.de>; Thu,  5 Mar 2020 02:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbgCEBg1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Mar 2020 20:36:27 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:34805 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbgCEBg1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Mar 2020 20:36:27 -0500
Received: by mail-yw1-f67.google.com with SMTP id o186so4151108ywc.1
        for <cgroups@vger.kernel.org>; Wed, 04 Mar 2020 17:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=elDmLeR3tSgLpvdXEISH+Yu3WidaDgNW2ZcPOQFDsvs=;
        b=qpBkUIA0/1+0YcJbMBGaG8rOed8G3LMa8MzpE1iD4ZC8ek6Q4lrDBzOybqocgiC8ob
         pD6WeVVKh2BrPywSmiLG7dpp8JIQYNNi+jxLH18jArlOXzg5VGKDJMXdGwTHBHDQ8hIv
         Up/QUizz6DzXVj8LhxLpAan2Qu1FG6cek6scVfjIvAoiAqaKvmPxhv+XDvSORpOjfuBi
         ZoiH8XmqL5hXI6+JaSLfPGCiAcZv7R6R3aCCTJReb8W8iX+QYTFS7EO/pUg9UwaqHC1N
         2Q4c+pmU8wSNqQbt09St9MSEFR0ydlw40nbYRgMGnxJ51Bpjv/hshzy0f6psUhQeXXAF
         AFnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=elDmLeR3tSgLpvdXEISH+Yu3WidaDgNW2ZcPOQFDsvs=;
        b=DGc0F3nhxwy7rv8kKUKao0XBmzZQeDjbl5I8nSwdBVEYN46ncWaiweNnNenQsEXayU
         V0HaQbsftoIz0xwav8L2PDGi4X0M6SC1gGBUrlyYC9UUYo0Lml9oKqTbXGeXQ6aId6en
         FicTwEh0jicUF/RdOG1Wxlnm5N3ox3wbtVWIrKrLcVDjTMq6TLvchDjbINvfyq+i7zmU
         cdmWEhB9G+DKR3pUL1Mhj2u3OSj9+5macboN8YfHmDJAn5osTa5loLA81mAOHbfNwC2Y
         UWbVZ8PQF2ECdFgRzSqmw5fNFEX7tzyvZPLvLoTQpAbB/nbH/TwDOCa3Yi7Ws4Su76zn
         Ba4w==
X-Gm-Message-State: ANhLgQ1lWhgYnapJh0g/X7CfU8shxlGVkXkt3jwi405bWDBbUztDBuI+
        6zr1Fi3hPK0YHJSfgQY2AqWNd70fiSAbxYPdrmiyQA==
X-Google-Smtp-Source: ADFU+vuVaTqAVDE0CXkgK9awzGSjwhPp2A3NtG4PdPRMu5B1+xOJ8wW8fF0AXsLV3KV9AODiOn4iHNOp9PhZYzCUhi0=
X-Received: by 2002:a25:bd0a:: with SMTP id f10mr5121241ybk.173.1583372185987;
 Wed, 04 Mar 2020 17:36:25 -0800 (PST)
MIME-Version: 1.0
References: <20200304233856.257891-1-shakeelb@google.com>
In-Reply-To: <20200304233856.257891-1-shakeelb@google.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 4 Mar 2020 17:36:14 -0800
Message-ID: <CANn89i+TiiLKsE7k4TyRqr03uNPW=UpkvpXL1LVWvTmhE_AUpA@mail.gmail.com>
Subject: Re: [PATCH v2] net: memcg: late association of sock to memcg
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        netdev <netdev@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Mar 4, 2020 at 3:39 PM Shakeel Butt <shakeelb@google.com> wrote:
>
> If a TCP socket is allocated in IRQ context or cloned from unassociated
> (i.e. not associated to a memcg) in IRQ context then it will remain
> unassociated for its whole life. Almost half of the TCPs created on the
> system are created in IRQ context, so, memory used by such sockets will
> not be accounted by the memcg.
>
> This issue is more widespread in cgroup v1 where network memory
> accounting is opt-in but it can happen in cgroup v2 if the source socket
> for the cloning was created in root memcg.
>
> To fix the issue, just do the late association of the unassociated
> sockets at accept() time in the process context and then force charge
> the memory buffer already reserved by the socket.
>
> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> ---
> Changes since v1:
> - added sk->sk_rmem_alloc to initial charging.
> - added synchronization to get memory usage and set sk_memcg race-free.
>
>  net/ipv4/inet_connection_sock.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
> index a4db79b1b643..7bcd657cd45e 100644
> --- a/net/ipv4/inet_connection_sock.c
> +++ b/net/ipv4/inet_connection_sock.c
> @@ -482,6 +482,25 @@ struct sock *inet_csk_accept(struct sock *sk, int flags, int *err, bool kern)
>                 }
>                 spin_unlock_bh(&queue->fastopenq.lock);
>         }
> +
> +       if (mem_cgroup_sockets_enabled && !newsk->sk_memcg) {
> +               int amt;
> +
> +               /* atomically get the memory usage and set sk->sk_memcg. */
> +               lock_sock(newsk);
> +
> +               /* The sk has not been accepted yet, no need to look at
> +                * sk->sk_wmem_queued.
> +                */
> +               amt = sk_mem_pages(newsk->sk_forward_alloc +
> +                                  atomic_read(&sk->sk_rmem_alloc));
> +               mem_cgroup_sk_alloc(newsk);
> +
> +               release_sock(newsk);
> +
> +               if (newsk->sk_memcg)

Most sockets in accept queue should have amt == 0, so maybe avoid
calling this thing only when amt == 0 ?

Also  I would release_sock(newsk) after this, otherwise incoming
packets could mess with newsk->sk_forward_alloc

if (amt && newsk->sk_memcg)
      mem_cgroup_charge_skmem(newsk->sk_memcg, amt);
release_sock(newsk);

Also, I wonder if     mem_cgroup_charge_skmem() has been used at all
these last four years
on arches with PAGE_SIZE != 4096

( SK_MEM_QUANTUM is not anymore PAGE_SIZE, but 4096)



> +                       mem_cgroup_charge_skmem(newsk->sk_memcg, amt);
> +       }
>  out:
>         release_sock(sk);
>         if (req)
> --
> 2.25.0.265.gbab2e86ba0-goog
>
