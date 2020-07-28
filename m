Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43EB7230E2E
	for <lists+cgroups@lfdr.de>; Tue, 28 Jul 2020 17:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730671AbgG1Plc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 28 Jul 2020 11:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730884AbgG1Plb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 28 Jul 2020 11:41:31 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFEDC0619D6
        for <cgroups@vger.kernel.org>; Tue, 28 Jul 2020 08:41:31 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id y18so8133948ilp.10
        for <cgroups@vger.kernel.org>; Tue, 28 Jul 2020 08:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vSWx1/Sr/gJvV92Fd2QuTQjvx6hegEt2EdSzZRTJZXM=;
        b=eOS9kCUGWozMEgHSZJcSVDFO0AHLhz5u13Hzr4euy1SfrsO3wctZ6YAEcFh81LUEFe
         qKEx883RdFNlnU/ciLWMOG+Vj2O3UtdPLRGu3wVgO4m2BQ37DnVzwEQRW6UlEXPC6X4+
         6qy3MKLhkiUeg2Gj1Hl5rFfX2WIKMSYf+TvHUXJLRYjJhA2RqWzGfAYi3i7oAIMDIOGN
         kWmCj7CoLh5z5B/OHRT7/QrMunwFyL57wmiHBTZtYJy1FwxdlHKoWKtw+zsNgVUo2ZHx
         EpjXSF+5KBb5kwwDmys2D0JqmY/qrmWuFn2WVlWcfsS5xNRgrwNQRXJP5bi8Bs1TigZW
         btwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vSWx1/Sr/gJvV92Fd2QuTQjvx6hegEt2EdSzZRTJZXM=;
        b=NKPIDUSkT5T7rsgVGyhB2taKl28ouZkZwXseYXp5nhOwnkrJy+lMFECm9Iar5cd1h4
         6QSX70hdU4vJ95YVu7Yk84Oejo5b9wdjTB5tiA+jnxvDRFOgoz7RstxAtsSF7/q77Jie
         EqUA5R/PMSmAiRGBXbEi+n0iXVZKiGx6gYt1LA9K59/WrjfPUdMOJlGOdpuqmaTVjL6J
         kMm0iWvo7xGzYmNln+0BjeWL/CuMENv5kpy3z6be5GSE/0HRddy8kIFFkseDxYHUhD8W
         1mJI5EYQ/IUffq0eyWfNJ3y5f80KoENq/6QbV8lGQlULVeuH0LCe7PCqLJ0Xz0PHRuFB
         vlvA==
X-Gm-Message-State: AOAM532ytWUeAObDBTTc7m65RRqVpDEJ/zCmQtbyZo4vKHQpSyT+5jgO
        /VzOwkWE5lM0uYcmy1UjUkdBq4GP1jM=
X-Google-Smtp-Source: ABdhPJyDr3/VSL/Sd0AZTRTnDaDXbKtAPJuxtlG2XtO6yQjepAU3x+9xL+YVZgu/NKlxbtyZpuHMhw==
X-Received: by 2002:a05:6e02:c6b:: with SMTP id f11mr411495ilj.272.1595950890232;
        Tue, 28 Jul 2020 08:41:30 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id u6sm2827959ilk.13.2020.07.28.08.41.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2020 08:41:29 -0700 (PDT)
Subject: Re: bdi cleanups v3
To:     Christoph Hellwig <hch@lst.de>
Cc:     Song Liu <song@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
        Richard Weinberger <richard@nod.at>,
        Minchan Kim <minchan@kernel.org>,
        linux-mtd@lists.infradead.org, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        drbd-dev@lists.linbit.com, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org
References: <20200724073313.138789-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0b2b59d4-da4c-33df-82b4-0d4935b91e6e@kernel.dk>
Date:   Tue, 28 Jul 2020 09:41:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200724073313.138789-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 7/24/20 1:32 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series contains a bunch of different BDI cleanups.  The biggest item
> is to isolate block drivers from the BDI in preparation of changing the
> lifetime of the block device BDI in a follow up series.

Applied, thanks.

-- 
Jens Axboe

