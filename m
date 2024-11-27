Return-Path: <cgroups+bounces-5704-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F15F9DAFD0
	for <lists+cgroups@lfdr.de>; Thu, 28 Nov 2024 00:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 862E1B21639
	for <lists+cgroups@lfdr.de>; Wed, 27 Nov 2024 23:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A29E197A9E;
	Wed, 27 Nov 2024 23:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="i8Zkk07i"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFED9433C8
	for <cgroups@vger.kernel.org>; Wed, 27 Nov 2024 23:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732749801; cv=none; b=CdZytT4O6/eBHSdhe/GJBkqW3euOkNzm7xuxYxO17bNJFa2+1tBRNPHc5AzDnotjbD25nRAO6dDk+pm3gsj/xtkkNWXuQElrM76JCkR5jAp/w1ZzHmMWhlR3ib+GAR9nqz8kkmcb2ACSnWUnXXRdCfhZkUmtkRvdbgfFW6DCI+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732749801; c=relaxed/simple;
	bh=+jPnjmSkIWnfw1ypNxPAHk3jExZky9QC/KYnqBebpVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rOQ+Fu7j9wuWgYDYhcRqHWoCH7l3UBfCKfTMRSodPF7YHdN6x3LbBfNOXlbDdlxJHE68zWfaCyBreG9y4O6SUqDZK15j1MPuirL+ABrJgGBcCt8ejYHw33cVTmSypJFoexu1kGjBM5slrqvl7vRjqdIBlMDwwUGOhg4BimNAAMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=i8Zkk07i; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2e9ed2dbfc8so48000a91.1
        for <cgroups@vger.kernel.org>; Wed, 27 Nov 2024 15:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732749798; x=1733354598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GYut6aU/zn0xLVmf0unpLL5mLReSDppc7n+P3njEiRE=;
        b=i8Zkk07iy6i0bYX1cjr0Kmph+xYYe/CRLb0hQKQ3kQRlK9a4bll70ZXjPhuEUd2dlQ
         4IPVmrpYX0GYAKLdT41b+ERK5p0X6rEgUKKt4V09zEmmTdh9dgc/PIMuRgrYiKNkyB1A
         jZVG50yPUfUVW3E8sxM45vdjeyFKoyK90n5nQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732749798; x=1733354598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GYut6aU/zn0xLVmf0unpLL5mLReSDppc7n+P3njEiRE=;
        b=XC6myn5DWbqjG35JQJ1dWPaMjHg4p3q7AS0phVcnv0FLAxt76goBDU/X+yadOPWnKd
         SOWp3acLps7PoOgPsAi2yD0O6HlIcMIeRWh5hmiNbkZr9WSnzm1TfyJ7M/jb1zOZKBmk
         iOcWKLHsz1lg8qjbq+YJoQ2AI9jn+oHov3oxfJWlnXqn6Pw1cikuVoIrXSeBMwGasK89
         gobBdRybFYCbs6BQ005CPCHcSrJYptS5CYMHtbZc1TJ2p5Fsy9aV3miCXltEZi7hmZ3Q
         EF5wrHxZORJAhNpljppAxto+jksUq6ZvMJFg3xecptdgy9uP73C6KZE08OLz4N7BX5le
         Y4fQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgy5EyU8Sp7Ls5BbNUgnlZuO1WAYsMKH+yRxTdGlqq62eIsSdR+x74sx3P9yvr8xyD9tTTGvA2@vger.kernel.org
X-Gm-Message-State: AOJu0YzMDbmmzMK8W88Mfa1lnDGuZlx1J6OQZiLv+3eGpEarisKZDZnM
	Hjqx8+73YAQPmbP2poUy+qyDTogdhQCpHsa7koNlV1i9SgCgOBNk17gLcwVgbPESEhBisDtB5TF
	ICj8m
X-Gm-Gg: ASbGnct2jHGFLm9TpMAwgG84Ped4b9hwC823LfkA4+uYF1+VZqTrPq06Obvra4WR5kk
	zrWOlpjZCcGv6CKaCg0pGvIPOXq4SmcBxKboFucQMPMlAv7k4fqyLOijUsIDTyOtYcHZZ06aPQ0
	kS78C530zxjoAnykVIRkIAsU+fk/JI3TjXbwfXosiLTGPQOI+P6pfa/ypAC+Soe4qmedZPCQW9e
	JPWn7le7jBTvnYIuRJEswAbb2U+7SnwuBd405r3vzs+GA3F2fhjFQtEyL1DUiGv5YE8lsp4Csz7
	nYEkpxCiE80s6g==
X-Google-Smtp-Source: AGHT+IEY9ZUgL92fDSEgGJjV6qCmCgCU9Blkq/JDckgFo1vzUGCui3oZq7RtDOTAY7TCFdYm8Vwdzw==
X-Received: by 2002:a17:90b:4a8f:b0:2ea:b4bc:b82c with SMTP id 98e67ed59e1d1-2ee08eb5e52mr2725011a91.3.1732749798231;
        Wed, 27 Nov 2024 15:23:18 -0800 (PST)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com. [209.85.216.42])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee0fa483ffsm2178918a91.19.2024.11.27.15.23.17
        for <cgroups@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2024 15:23:17 -0800 (PST)
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2edb222a786so247423a91.1
        for <cgroups@vger.kernel.org>; Wed, 27 Nov 2024 15:23:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXW7Jgaa1w/M2DNhM6iAIZMStm286/d87WomDaC2AZKU8NbDmddj6Nposxmies9YuXW1tTw4fNp@vger.kernel.org
X-Received: by 2002:a17:902:f382:b0:212:655c:caf with SMTP id
 d9443c01a7336-21501e5af92mr39560115ad.55.1732749318060; Wed, 27 Nov 2024
 15:15:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127025728.3689245-1-yuanchu@google.com> <20241127025728.3689245-10-yuanchu@google.com>
In-Reply-To: <20241127025728.3689245-10-yuanchu@google.com>
From: Daniel Verkamp <dverkamp@chromium.org>
Date: Wed, 27 Nov 2024 15:14:52 -0800
X-Gmail-Original-Message-ID: <CABVzXAnbSeUezF_dqk2=6HGTCd09T4rd6AssP7-dbCgZSkZgiw@mail.gmail.com>
Message-ID: <CABVzXAnbSeUezF_dqk2=6HGTCd09T4rd6AssP7-dbCgZSkZgiw@mail.gmail.com>
Subject: Re: [PATCH v4 9/9] virtio-balloon: add workingset reporting
To: Yuanchu Xie <yuanchu@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Khalid Aziz <khalid.aziz@oracle.com>, 
	Henry Huang <henry.hj@antgroup.com>, Yu Zhao <yuzhao@google.com>, 
	Dan Williams <dan.j.williams@intel.com>, Gregory Price <gregory.price@memverge.com>, 
	Huang Ying <ying.huang@intel.com>, Lance Yang <ioworker0@gmail.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Muhammad Usama Anjum <usama.anjum@collabora.com>, 
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Mike Rapoport <rppt@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Daniel Watson <ozzloy@each.do>, cgroups@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 7:00=E2=80=AFPM Yuanchu Xie <yuanchu@google.com> wr=
ote:
[...]
> diff --git a/include/linux/workingset_report.h b/include/linux/workingset=
_report.h
> index f6bbde2a04c3..1074b89035e9 100644
> --- a/include/linux/workingset_report.h
> +++ b/include/linux/workingset_report.h
[...]
> diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/vir=
tio_balloon.h
> index ee35a372805d..668eaa39c85b 100644
> --- a/include/uapi/linux/virtio_balloon.h
> +++ b/include/uapi/linux/virtio_balloon.h
> @@ -25,6 +25,7 @@
>   * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY=
 WAY
>   * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY O=
F
>   * SUCH DAMAGE. */
> +#include "linux/workingset_report.h"
>  #include <linux/types.h>
>  #include <linux/virtio_types.h>
>  #include <linux/virtio_ids.h>

This seems to be including a non-uapi header
(include/linux/workingset_report.h) from a uapi header
(include/uapi/linux/virtio_balloon.h), which won't compile outside the
kernel. Does anything in the uapi actually need declarations from
workingset_report.h?

> @@ -37,6 +38,7 @@
>  #define VIRTIO_BALLOON_F_FREE_PAGE_HINT        3 /* VQ to report free pa=
ges */
>  #define VIRTIO_BALLOON_F_PAGE_POISON   4 /* Guest is using page poisonin=
g */
>  #define VIRTIO_BALLOON_F_REPORTING     5 /* Page reporting virtqueue */
> +#define VIRTIO_BALLOON_F_WS_REPORTING  6 /* Working Set Size reporting *=
/
>
>  /* Size of a PFN in the balloon interface. */
>  #define VIRTIO_BALLOON_PFN_SHIFT 12
> @@ -128,4 +130,32 @@ struct virtio_balloon_stat {
>         __virtio64 val;
>  } __attribute__((packed));
>
> +/* Operations from the device */
> +#define VIRTIO_BALLOON_WS_OP_REQUEST 1
> +#define VIRTIO_BALLOON_WS_OP_CONFIG 2
> +
> +struct virtio_balloon_working_set_notify {
> +       /* REQUEST or CONFIG */
> +       __le16 op;
> +       __le16 node_id;
> +       /* the following fields valid iff op=3DCONFIG */
> +       __le32 report_threshold;
> +       __le32 refresh_interval;
> +       __le32 idle_age[WORKINGSET_REPORT_MAX_NR_BINS];
> +};
> +
> +struct virtio_balloon_working_set_report_bin {
> +       __le64 idle_age;
> +       /* bytes in this bucket for anon and file */
> +       __le64 anon_bytes;
> +       __le64 file_bytes;
> +};
> +
> +struct virtio_balloon_working_set_report {
> +       __le32 error;
> +       __le32 node_id;
> +       struct virtio_balloon_working_set_report_bin
> +               bins[WORKINGSET_REPORT_MAX_NR_BINS];
> +};
> +
>  #endif /* _LINUX_VIRTIO_BALLOON_H */

Have the spec changes been discussed in the virtio TC?

Thanks,
-- Daniel

